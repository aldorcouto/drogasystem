from read import ut, Read

# classe personalizada para listar medicamentos
class MedicamentoRead(Read):
  # personaliza atributos da lista
  def set_cols_rows(self):
    sql = "select "
    sql += "medicamento.id, laboratorio.nome as laboratorio, medicamento.nome, medicamento.tipo, medicamento.quantidade, medicamento.preco "
    sql += "from medicamento "
    sql += "join laboratorio on laboratorio.id = medicamento.laboratorio_id "
    sql += "order by 1"
    self.rows = self.model.find_by_sql(sql)
    self.cols = [ut.corretor(c) for c in self.model.columns()]
