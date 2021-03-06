VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cls_Threads"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Private Declare Sub Sleep Lib "kernel32.dll" (ByVal dwMilliseconds As Long)



Public Function Foo()
    MsgBox "foo"
End Function
'
'ESPEC�FICA��O 2 - Processo de entrada do ve�culo
'
Public Sub rand_ini_entrada()

'Ap�s tempo aleat�rio entre 1 e 5 segundos, um ve�culo do estacionamento inicia processo de entrada

'Vari�veis locais e internas
Dim tempoRndEntrada As Integer
Dim LimiteMin As Integer
Dim LimiteMax As Integer
LimiteMin = 1000 'Tempo m�nimo da aleatoriedade de entrada em milisegundos
LimiteMax = 5000 'Tempo m�ximo da aleatoriedade de entrada em milisegundos

'Fun��o utilizada para randomizar um valor de tempo com resolu��o de milisegundos
Randomize (10) 'Gera uma nova seed baseada no timer do sistema para a fun��o Rnd()
tempoRndEntrada = Int((LimiteMax - LimiteMin + 1) * Rnd() + LimiteMin) 't em milisegundos
Sleep (tempoRndEntrada) 'delay

'Ap�s o tempo, adiciona ve�culo a fila de entrada, a mudan�a de valor desencadeia uma verifica��o de cancela dispon�vel
'Se houver cancela dispon�vel, o ve�culo � "instant�neamente" movido para o processo de entrada
'Quando Text3 muda, a fun��o "Text3_TextChanged" � chamada atrav�s de evento "called by changed value")
'Pode ocorrer um erro quando fecha o programa, porque ele tenta finalizar o processo sem valor, n�o impacta no resultado.

'Adiciona ve�culo na fila de entrada Text3 = Fila de Entrada

End Sub
'
'ESPEC�FICA��O 3 - Processo de sa�da do ve�culo
'
Public Sub rand_ini_saida()

'Ap�s tempo aleat�rio entre 10 e 30 segundos, um ve�culo do estacionamento inicia processo de entrada

'Vari�veis locais e internas
Dim tempoRndEntrada As Integer
Dim LimiteMin As Integer
Dim LimiteMax As Integer
LimiteMin = 10000 'Tempo m�nimo da aleatoriedade de saida em milisegundos
LimiteMax = 30000 'Tempo m�ximo da aleatoriedade de saida em milisegundos

'Fun��o utilizada para randomizar um valor de tempo com resolu��o de milisegundos
Randomize (594) 'Gera uma nova seed baseada no timer do sistema para a fun��o Rnd()
tempoRndEntrada = Int((LimiteMax - LimiteMin + 1) * Rnd() + LimiteMin) 't em milisegundos
Sleep (tempoRndEntrada) 'delay

'Ap�s o tempo, adiciona ve�culo a fila de entrada, a mudan�a de valor desencadeia uma verifica��o de cancela dispon�vel
'Se houver cancela dispon�vel, o ve�culo � "instant�neamente" movido para o processo de entrada
'Quando Text4 muda, a fun��o "Text4_TextChanged" � chamada atrav�s de evento "called by changed value")
'Pode ocorrer um erro quando fecha o programa, porque ele tenta finalizar o processo sem valor, n�o impacta no resultado.

'Adiciona ve�culo na fila de entrada Text4 = Fila de Saida


End Sub
'
' ESPEC�FICA��O 4.1 - Processo de ENTRADA de ve�culos
'
Public Sub rand_proc_entrada()

        'Ap�s verifica��o de disponibilidade de cancela de entrada (value change do textbox3)
        'Inicia processo de entrada de ve�culo, ap�s tempo aleat�rio entre 3 e 5 segundos,
        'conclui 1 processo de entrada do ve�culo e move 1 ve�culo da fila de entrada para o estacionamento
        'Adiciona 1 no contador de ve�culos que passaram pela entrada no final da fun��o
        'Nesse caso n�o h� loop pois existe fun��o de ativa��o a partir da verifica��o de cancelas (value change do textbox3)
        'MsgBox("Iniciando Processo de Entrada") '<- UTILIZADO NO DEBUG

        'Move ve�culo da fila de espera para cancela (ocupa 1 vaga de cancela de entrada)
        ''Retira 1 ve�culo na fila de entrada (considerando que processo de entrada n�o faz parte do processo de espera "fila de espera")

        'Ocupa 1 cancela, retira 1 no n�mero de cancelas de entrada dispon�vel enquanto houver o processamento
        ''entradasDisponiveis = entradasDisponiveis - 1 'Declara que uma das cancelas de entrada dispon�veis n�o est� mais dispon�vel
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
        Randomize (95) 'Gera uma nova seed baseada no timer do sistema para a fun��o Rnd()
        tempoRndPEntrada = Int((LimiteMax - LimiteMin + 1) * Rnd() + LimiteMin) 't em milisegundos

        Sleep (tempoRndPEntrada) 'Aplica delay no Thread

        'Desocupa 1 cancela, disponibiliza +1 no n�mero de cancelas de entrada dispon�vel no fim do processamento
        ''entradasDisponiveis = entradasDisponiveis + 1 'Ao final disponibiliza novamente a cancela para um novo ve�culo (um novo thread pode ser iniciado)
        'Console.WriteLine("Cancelas de Entrada Dispon�veis: " & entradasDisponiveis) '<- UTILIZADO NO DEBUG

        'Conclui processo de entrada e contabiliza dados nos respectivos locais de armazenamento de informa��o (O ideal era criar vari�veis ou colocar em um banco de dados para n�o perder a informa��o)
        ''Text5.Text = Val(Text5.Text) + 1 'Adiciona 1 ve�culo no n�mero de ve�culos que passaram pela entrada
        ''Text7.Text = Val(Text7.Text) + 1 'Adiciona 1 ve�culo no n�mero de ve�culos dentro do estacionamento

End Sub
'
' ESPEC�FICA��O 4.2 - Processo de SA�DA de ve�culos
'
Public Sub rand_proc_saida()
        'Ap�s verifica��o de disponibilidade de cancela de entrada (value change do textbox3)
        'Inicia processo de entrada de ve�culo, ap�s tempo aleat�rio entre 3 e 5 segundos,
        'conclui 1 processo de entrada do ve�culo e move 1 ve�culo da fila de entrada para o estacionamento
        'Adiciona 1 no contador de ve�culos que passaram pela entrada no final da fun��o
        'Nesse caso n�o h� loop pois existe fun��o de ativa��o a partir da verifica��o de cancelas (value change do textbox3)
        'MsgBox("Iniciando Processo de Entrada")

        'Move da fila de espera para cancela (ocupa 1 vaga de cancela de entrada)
        ''Text4.Text = Val(Text4.Text) - 1 'Retira 1 ve�culo na fila de saida (considerando que processo de entrada n�o faz parte do processo de espera "fila de espera")
        ''saidasDisponiveis = saidasDisponiveis - 1 'Declara que uma das cancelas de entrada dispon�veis n�o est� mais dispon�vel
        'As vezes, por conta da execu��o do Thread, pode aparecer que o n�mero de entradas ficou negativo no console, por�m � um problema da execu��o
        'Do thread que na verdade executa de forma alternada os diferentes processos e eventualmente ocorre esse bug. (n�o altera o funcionamento do programa)

        'Vari�veis locais e internas
        Dim tempoRndPSaida As Integer
        Dim LimiteMin As Integer
        Dim LimiteMax As Integer
        LimiteMin = 3000 'Tempo m�nimo da aleatoriedade de processo de entrada em milisegundos
        LimiteMax = 5000 'Tempo m�ximo da aleatoriedade de processo de entrada em milisegundos

        'Fun��o utilizada para randomizar um valor de tempo com resolu��o de milisegundos
        Randomize (49) 'Gera uma nova seed baseada no timer do sistema para a fun��o Rnd()
        tempoRndPSaida = Int((LimiteMax - LimiteMin + 1) * Rnd() + LimiteMin) 't em milisegundos
        Sleep (tempoRndPSaida) 'Aplica delay no Thread

        'Conclui processo de entrada e contabiliza dados nos respectivos locais de armazenamento de informa��o (O ideal era criar vari�veis ou colocar em um banco de dados para n�o perder a informa��o)
        ''saidasDisponiveis = saidasDisponiveis + 1 'Ao final disponibiliza novamente a cancela para um novo ve�culo (um novo thread pode ser iniciado)
    
        ''Text6.Text = Val(Text6.Text) + 1 'Adiciona 1 ve�culo no n�mero de ve�culos que passaram pela saida
        ''Text7.Text = Val(Text7.Text) - 1 'Subtrai 1 ve�culo no n�mero de ve�culos dentro do estacionamento
End Sub


