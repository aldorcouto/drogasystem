from app import sg, App

# tela padrão para atualizar e criar um registro
class Save(App):
  # define os componentes da tela
  def view(self):
    content = self.get_content()
    btns = [sg.Button(" Voltar "), sg.Button(" Salvar ")]
    if self.add_extra_button(): btns.append(self.add_extra_button())
    
    col1 = [[sg.Image(f'images/{self.model.tname.lower()}_vertical.png')]]
    col2 = [
      [self.titulo(f"{'Criar' if self.dic['id'] == '' else 'Atualizar'} {self.corretor(self.model.tname)}")], 
      [sg.HorizontalSeparator()], 
      *content, 
      [sg.HorizontalSeparator()], 
      [sg.Text(key="-SAIDA-")], 
      btns]
    layout = [[sg.Column(col1), sg.Column(col2, vertical_alignment='top')]]
    
    self.window = sg.Window(self.win_title(), layout, size=(800, 520))
    
  # define ações e regras da tela
  def controller(self, event, values):
    if event == " Salvar ":
      params = self.get_params(values)
      if self.dic["id"] == "":
        self.error_out(self.model.insert(params))
      else:
        self.error_out(self.model.update(params))

      if self.error == "":
        self.error = "Fechar"
      
    self.controller_helper(event, values)

  # método auxiliar que gera outros componentes da tela
  def get_content(self):
    return [[
      sg.Text(text=f"{self.corretor(k).title()}: ", size=12), 
      sg.Input(default_text=v, key=f"-{k.upper()}-", disabled=(k=="id"))]
      for k, v in self.dic.items()]

  # método auxiliar para definir conteúdo do registro que será enviado ao banco
  def get_params(self, values):
    return {
      str(key).replace("-", "").lower(): val 
      for key, val in values.items() 
      if str(key).replace("-", "").lower() in self.dic.keys()
    }

  # método auxiliar para inserir botões extra na tela
  def add_extra_button(self):
    return None
  
  # método abstract opcional de ações e regras
  def controller_helper(self, event, values):
    pass
