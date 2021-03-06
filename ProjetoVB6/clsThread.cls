VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsThread"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

'
' ESPEC�FICA��O 4.1 - Processo de ENTRADA de ve�culos
'
Public Sub ProcessoEntrada()
    'Ap�s verifica��o de disponibilidade de cancela de entrada (value change do textbox3)
    'Inicia processo de entrada de ve�culo, ap�s tempo aleat�rio entre 3 e 5 segundos,
    'conclui 1 processo de entrada do ve�culo e move 1 ve�culo da fila de entrada para o estacionamento
    'Adiciona 1 no contador de ve�culos que passaram pela entrada no final da fun��o
    'Nesse caso n�o h� loop pois existe fun��o de ativa��o a partir da verifica��o de cancelas (value change do textbox3)
    'MsgBox("Iniciando Processo de Entrada") '<- UTILIZADO NO DEBUG

    'Move ve�culo da fila de espera para cancela (ocupa 1 vaga de cancela de entrada)
    TextBox3.Text = Val(TextBox3.Text) - 1 'Retira 1 ve�culo na fila de entrada (considerando que processo de entrada n�o faz parte do processo de espera "fila de espera")

    'Ocupa 1 cancela, retira 1 no n�mero de cancelas de entrada dispon�vel enquanto houver o processamento
    entradasDisponiveis = entradasDisponiveis - 1 'Declara que uma das cancelas de entrada dispon�veis n�o est� mais dispon�vel
    'As vezes, por conta da execu��o do Thread, pode aparecer que o n�mero de entradas ficou negativo no console, por�m � um problema da execu��o
    'Do thread que na verdade executa de forma alternada os diferentes processos e eventualmente ocorre esse bug. (n�o altera o funcionamento do programa)
    'Console.WriteLine("Cancelas de Entrada Dispon�veis: " & entradasDisponiveis) '<- UTILIZADO NO DEBUG

    'Vari�veis locais e internas
    Dim tempoRndPEntrada As Integer
    Dim LimiteMin As Integer
    Dim LimiteMax As Integer
    LimiteMin = 3000 'Tempo m�nimo da aleatoriedade de processo de entrada em milisegundos
    LimiteMax = 5000 'Tempo m�ximo da aleatoriedade de processo de entrada em milisegundos

    'Fun��o utilizada para randomizar um valor de tempo com resolu��o de milisegundos
    ''Randomize() 'Gera uma nova seed baseada no timer do sistema para a fun��o Rnd()
    tempoRndPEntrada = Int((LimiteMax - LimiteMin + 1) * Rnd() + LimiteMin) 't em milisegundos

    System.Threading.Thread.CurrentThread.Sleep (tempoRndPEntrada) 'Aplica delay no Thread

    'Desocupa 1 cancela, disponibiliza +1 no n�mero de cancelas de entrada dispon�vel no fim do processamento
    entradasDisponiveis = entradasDisponiveis + 1 'Ao final disponibiliza novamente a cancela para um novo ve�culo (um novo thread pode ser iniciado)
    'Console.WriteLine("Cancelas de Entrada Dispon�veis: " & entradasDisponiveis) '<- UTILIZADO NO DEBUG

    'Conclui processo de entrada e contabiliza dados nos respectivos locais de armazenamento de informa��o (O ideal era criar vari�veis ou colocar em um banco de dados para n�o perder a informa��o)
    TextBox5.Text = Val(TextBox5.Text) + 1 'Adiciona 1 ve�culo no n�mero de ve�culos que passaram pela entrada
    TextBox7.Text = Val(TextBox7.Text) + 1 'Adiciona 1 ve�culo no n�mero de ve�culos dentro do estacionamento

End Sub

'
' ESPEC�FICA��O 4.2 - Processo de SA�DA de ve�culos
'
Public Sub ProcessoSaida()
    'Ap�s verifica��o de disponibilidade de cancela de entrada (value change do textbox3)
    'Inicia processo de entrada de ve�culo, ap�s tempo aleat�rio entre 3 e 5 segundos,
    'conclui 1 processo de entrada do ve�culo e move 1 ve�culo da fila de entrada para o estacionamento
    'Adiciona 1 no contador de ve�culos que passaram pela entrada no final da fun��o
    'Nesse caso n�o h� loop pois existe fun��o de ativa��o a partir da verifica��o de cancelas (value change do textbox3)
    'MsgBox("Iniciando Processo de Entrada")

    'Move da fila de espera para cancela (ocupa 1 vaga de cancela de entrada)
    TextBox4.Text = Val(TextBox4.Text) - 1 'Retira 1 ve�culo na fila de saida (considerando que processo de entrada n�o faz parte do processo de espera "fila de espera")
    saidasDisponiveis = saidasDisponiveis - 1 'Declara que uma das cancelas de entrada dispon�veis n�o est� mais dispon�vel
    'As vezes, por conta da execu��o do Thread, pode aparecer que o n�mero de entradas ficou negativo no console, por�m � um problema da execu��o
    'Do thread que na verdade executa de forma alternada os diferentes processos e eventualmente ocorre esse bug. (n�o altera o funcionamento do programa)
    Console.WriteLine ("Cancelas de Sa�das Dispon�veis: " & saidasDisponiveis)

    'Vari�veis locais e internas
    Dim tempoRndPSaida As Integer
    Dim LimiteMin As Integer
    Dim LimiteMax As Integer
    LimiteMin = 3000 'Tempo m�nimo da aleatoriedade de processo de entrada em milisegundos
    LimiteMax = 5000 'Tempo m�ximo da aleatoriedade de processo de entrada em milisegundos

    'Fun��o utilizada para randomizar um valor de tempo com resolu��o de milisegundos
    ''Randomize() 'Gera uma nova seed baseada no timer do sistema para a fun��o Rnd()
    tempoRndPSaida = Int((LimiteMax - LimiteMin + 1) * Rnd() + LimiteMin) 't em milisegundos
    System.Threading.Thread.CurrentThread.Sleep (tempoRndPSaida) 'Aplica delay no Thread

    'Conclui processo de entrada e contabiliza dados nos respectivos locais de armazenamento de informa��o (O ideal era criar vari�veis ou colocar em um banco de dados para n�o perder a informa��o)
    saidasDisponiveis = saidasDisponiveis + 1 'Ao final disponibiliza novamente a cancela para um novo ve�culo (um novo thread pode ser iniciado)
    Console.WriteLine ("Cancelas de Sa�das Dispon�veis: " & saidasDisponiveis)
    TextBox6.Text = Val(TextBox6.Text) + 1 'Adiciona 1 ve�culo no n�mero de ve�culos que passaram pela saida
    TextBox7.Text = Val(TextBox7.Text) - 1 'Subtrai 1 ve�culo no n�mero de ve�culos dentro do estacionamento

End Sub

'
'ESPEC�FICA��O 2 - Processo de entrada do ve�culo
'
Public Sub IniciarEntrada()

    'Ap�s tempo aleat�rio entre 1 e 5 segundos, um ve�culo do estacionamento inicia processo de entrada
    While True 'Loop Infinito (CUIDADO para n�o mudar algo no c�digo e sobrecarregar o sistema) <- ATEN��O!

        'Vari�veis locais e internas
        Dim tempoRndEntrada As Integer
        Dim LimiteMin As Integer
        Dim LimiteMax As Integer
        LimiteMin = 1000 'Tempo m�nimo da aleatoriedade de entrada em milisegundos
        LimiteMax = 5000 'Tempo m�ximo da aleatoriedade de entrada em milisegundos

        'Fun��o utilizada para randomizar um valor de tempo com resolu��o de milisegundos
        ''Randomize() 'Gera uma nova seed baseada no timer do sistema para a fun��o Rnd()
        tempoRndEntrada = Int((LimiteMax - LimiteMin + 1) * Rnd() + LimiteMin) 't em milisegundos

        System.Threading.Thread.CurrentThread.Sleep (tempoRndEntrada) 'Aplica delay no Thread

        'Ap�s o tempo, adiciona ve�culo a fila de entrada, a mudan�a de valor desencadeia uma verifica��o de cancela dispon�vel
        'Se houver cancela dispon�vel, o ve�culo � "instant�neamente" movido para o processo de entrada
        'Quando TextBox3 muda, a fun��o "TextBox3_TextChanged" � chamada atrav�s de evento "called by changed value")
        'Pode ocorrer um erro quando fecha o programa, porque ele tenta finalizar o processo sem valor, n�o impacta no resultado.
        TextBox3.Text = Val(TextBox3.Text) + 1 'Adiciona ve�culo na fila de entrada TextBox3 = Fila de Entrada

    Wend
End Sub
'
'ESPEC�FICA��O 3 - Processo de sa�da do ve�culo
'
Public Sub IniciarSaida()

    'Ap�s tempo aleat�rio entre 10 e 30 segundos, um ve�culo do estacionamento inicia processo de sa�da
    While True 'Loop Infinito (Cuidado para n�o mudar algo no c�digo e sobrecarregar o sistema)

        'Vari�veis locais e internas
        Dim tempoRndSaida As Integer
        Dim LimiteMin As Integer
        Dim LimiteMax As Integer
        LimiteMin = 10000 'Tempo m�nimo da aleatoriedade de saida em milisegundos
        LimiteMax = 30000 'Tempo m�ximo da aleatoriedade de saida em milisegundos

        'Fun��o utilizada para randomizar um valor de tempo com resolu��o de milisegundos
        ''Randomize() 'Gera uma nova seed baseada no timer do sistema para a fun��o Rnd()
        tempoRndSaida = Int((LimiteMax - LimiteMin + 1) * Rnd() + LimiteMin) 't em milisegundos

        System.Threading.Thread.CurrentThread.Sleep (tempoRndSaida) 'Aplica delay no Thread

        'Ap�s o tempo, um ve�culo do estacionamento inicia processo de sa�da do estacionamento,
        'Quando TextBox4 muda, a fun��o "TextBox4_TextChanged" � chamada atrav�s de evento "called by changed value")
        'Se houver cancela de sa�da dispon�vel, o ve�culo ser� "instant�neamente" movido para o processo de sa�da
        TextBox7.Text = Val(TextBox7.Text) - 1 'Um ve�culo deixa o estacionamento
        TextBox4.Text = Val(TextBox4.Text) + 1 'Um ve�culo vai pra fila ou processo de saida
    Wend

End Sub

