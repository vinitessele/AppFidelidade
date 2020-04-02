object DM: TDM
  OldCreateOrder = False
  Height = 393
  Width = 535
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\vinic\Documents\Embarcadero\Studio\Projects\Ap' +
        'pFidelidade\Bd\bd.db'
      'LockingMode=Normal'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    AfterConnect = FDConnection1AfterConnect
    BeforeConnect = FDConnection1BeforeConnect
    Left = 56
    Top = 16
  end
  object FDQParametro: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from parametro')
    Left = 48
    Top = 80
    object FDQParametroparametro_nome: TStringField
      FieldName = 'parametro_nome'
      Origin = 'parametro_nome'
      Size = 60
    end
    object FDQParametroparametro_logo: TBlobField
      FieldName = 'parametro_logo'
      Origin = 'parametro_logo'
    end
    object FDQParametroparametro_login: TStringField
      FieldName = 'parametro_login'
      Origin = 'parametro_login'
      Size = 100
    end
    object FDQParametroparametro_totalpontos: TIntegerField
      FieldName = 'parametro_totalpontos'
      Origin = 'parametro_totalpontos'
    end
    object FDQParametroparametro_premio: TStringField
      FieldName = 'parametro_premio'
      Origin = 'parametro_premio'
      Size = 100
    end
    object FDQParametroparametro_senha: TStringField
      FieldName = 'parametro_senha'
      Origin = 'parametro_senha'
      Size = 10
    end
  end
  object FDQClienteAll: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from cliente'
      'order by cliente_nome asc')
    Left = 151
    Top = 16
    object FDQClienteAllcliente_id: TFDAutoIncField
      FieldName = 'cliente_id'
      Origin = 'cliente_id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQClienteAllcliente_cpf: TStringField
      FieldName = 'cliente_cpf'
      Origin = 'cliente_cpf'
      Size = 11
    end
    object FDQClienteAllcliente_nome: TStringField
      FieldName = 'cliente_nome'
      Origin = 'cliente_nome'
      Size = 60
    end
    object FDQClienteAllcliente_celular: TStringField
      FieldName = 'cliente_celular'
      Origin = 'cliente_celular'
      Size = 12
    end
    object FDQClienteAllcliente_email: TStringField
      FieldName = 'cliente_email'
      Origin = 'cliente_email'
      Size = 100
    end
    object FDQClienteAllcliente_img: TBlobField
      FieldName = 'cliente_img'
      Origin = 'cliente_img'
    end
  end
  object FDQPontuacao: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from pontuacao')
    Left = 143
    Top = 80
    object FDQPontuacaopontuacao_id: TFDAutoIncField
      FieldName = 'pontuacao_id'
      Origin = 'pontuacao_id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQPontuacaopontuacao_id_cliente: TIntegerField
      FieldName = 'pontuacao_id_cliente'
      Origin = 'pontuacao_id_cliente'
    end
    object FDQPontuacaopontuacao_pontos: TIntegerField
      FieldName = 'pontuacao_pontos'
      Origin = 'pontuacao_pontos'
    end
    object FDQPontuacaopontuacao_data: TDateField
      FieldName = 'pontuacao_data'
      Origin = 'pontuacao_data'
    end
  end
  object FDQSomaPontos: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'select coalesce(sum(pontuacao_pontos),0) as pontuacao from pontu' +
        'acao'
      'where pontuacao_id_cliente = :idCliente')
    Left = 39
    Top = 168
    ParamData = <
      item
        Name = 'IDCLIENTE'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end>
    object FDQSomaPontospontuacao: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'pontuacao'
      Origin = 'pontuacao'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object FDQCliente: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from cliente'
      'where cliente_cpf = :cpf')
    Left = 256
    Top = 24
    ParamData = <
      item
        Name = 'CPF'
        DataType = ftString
        ParamType = ptInput
        Value = '1'
      end>
    object FDQClientecliente_id: TFDAutoIncField
      FieldName = 'cliente_id'
      Origin = 'cliente_id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQClientecliente_cpf: TStringField
      FieldName = 'cliente_cpf'
      Origin = 'cliente_cpf'
      Size = 11
    end
    object FDQClientecliente_nome: TStringField
      FieldName = 'cliente_nome'
      Origin = 'cliente_nome'
      Size = 60
    end
    object FDQClientecliente_celular: TStringField
      FieldName = 'cliente_celular'
      Origin = 'cliente_celular'
      Size = 12
    end
    object FDQClientecliente_email: TStringField
      FieldName = 'cliente_email'
      Origin = 'cliente_email'
      Size = 100
    end
    object FDQClientecliente_img: TBlobField
      FieldName = 'cliente_img'
      Origin = 'cliente_img'
    end
  end
  object FDQPontuacaoZera: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from pontuacao where pontuacao_id_cliente =:idcliente')
    Left = 239
    Top = 88
    ParamData = <
      item
        Name = 'IDCLIENTE'
        DataType = ftString
        ParamType = ptInput
        Value = '1'
      end>
    object FDQPontuacaoZerapontuacao_id: TFDAutoIncField
      FieldName = 'pontuacao_id'
      Origin = 'pontuacao_id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQPontuacaoZerapontuacao_id_cliente: TIntegerField
      FieldName = 'pontuacao_id_cliente'
      Origin = 'pontuacao_id_cliente'
    end
    object FDQPontuacaoZerapontuacao_pontos: TIntegerField
      FieldName = 'pontuacao_pontos'
      Origin = 'pontuacao_pontos'
    end
    object FDQPontuacaoZerapontuacao_data: TDateField
      FieldName = 'pontuacao_data'
      Origin = 'pontuacao_data'
    end
  end
  object FDQProcedimentos: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'select * from procedimento')
    Left = 359
    Top = 80
    object FDQProcedimentosprocedimento_id: TFDAutoIncField
      FieldName = 'procedimento_id'
      Origin = 'procedimento_id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQProcedimentosprocedimento_descricao: TStringField
      FieldName = 'procedimento_descricao'
      Origin = 'procedimento_descricao'
      Size = 70
    end
    object FDQProcedimentosprocedimento_valor: TFMTBCDField
      FieldName = 'procedimento_valor'
      Origin = 'procedimento_valor'
      Precision = 4
    end
    object FDQProcedimentosprocedimento_pontos: TIntegerField
      FieldName = 'procedimento_pontos'
      Origin = 'procedimento_pontos'
    end
    object FDQProcedimentosprocedimentos_status: TStringField
      FieldName = 'procedimentos_status'
      Origin = 'procedimentos_status'
      FixedChar = True
      Size = 1
    end
    object FDQProcedimentosprocedimentos_img: TBlobField
      FieldName = 'procedimentos_img'
      Origin = 'procedimentos_img'
    end
  end
end
