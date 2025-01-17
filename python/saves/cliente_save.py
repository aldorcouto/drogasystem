from save import sg, ut, Save

# classe personalizada de atualização do cliente
class ClienteSave(Save):
  # personaliza atributos editáveis
  def get_content(self):
    self.pessoa = self.model.pessoa.find(self.dic['id'] or 0)

    # atributos pessoa
    content = [[
      sg.Text(text=f"{ut.corretor(k, title=True)}: ", size=14), 
      sg.Input(default_text=v, key=f"-{k.upper()}-", disabled=(k=="id"))
    ] for k, v in self.pessoa.items()]
    
    # atributos cliente
    for k, v in self.dic.items():
      if k == "id":
        continue

      aux = [sg.Text(text=f"{ut.corretor(k, title=True)}: ", size=14)]
      if k == "data_nasc": 
        aux.append(sg.Input(default_text=v, key=f"-{k.upper()}-", size=32, disabled=True))
        aux.append(sg.CalendarButton("CALENDÁRIO", size=13, font=('Arial Bold', 7), close_when_date_chosen=True, 
          target=f"-{k.upper()}-", format='%Y-%m-%d', default_date_m_d_y=(v.month, v.day, v.year)))
      elif k == "sexo":
        aux.append(sg.Combo(["Masculino", "Feminino"], default_value="Masculino" if v == "M" else "Feminino", key=f"-{k.upper()}-", size=44))
      else:
        aux.append(sg.Input(default_text=v, key=f"-{k.upper()}-", disabled=(k=="id")))
      
      content.append(aux)

    # content.extend([[
    #   sg.Text(text=f"{ut.corretor(k, title=True)}: ", size=14), 
    #   sg.Input(default_text=v, key=f"-{k.upper()}-")
    #   if k != "data_nasc" else
    #     sg.Input(default_text=v, key=f"-{k.upper()}-", size=32, disabled=True),
    #     sg.CalendarButton("CALENDÁRIO", font=('Arial Bold', 7), 
    #       close_when_date_chosen=True, target=f"-{k.upper()}-", format='%Y-%m-%d', size=13)
    # ] for k, v in self.dic.items() if k != "id"])

    return content
  
  # retorna vazio para desativar a gravação padrão e controlar em controller_helper
  def get_params(self, values, dic):
    return {}

  # gravação personalizada
  def controller_helper(self, event, values):
    if event == " Salvar ":
      cliente = super().get_params(values, self.dic)
      cliente["sexo"] = cliente["sexo"][0]
      pessoa = {
        str(key).replace("-", "").lower(): val 
        for key, val in values.items() 
        if str(key).replace("-", "").lower() in self.pessoa.keys()
      }

      if pessoa["id"] == "":
        aux = self.model.pessoa.find_by_sql('select max(id) + 1 id from pessoa;')
        pessoa["id"] = aux[0][0]
        cliente["id"] = aux[0][0]
        sql = self.model.pessoa.sql_ins(pessoa)
        sql += self.model.sql_ins(cliente)
      else:
        sql = self.model.pessoa.sql_upd(pessoa)
        sql += self.model.sql_upd(cliente)
      self.error_out(self.model.commit(sql))