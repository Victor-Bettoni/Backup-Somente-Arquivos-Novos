@echo off
setlocal enabledelayedexpansion
:Mensagem aviso
echo.
echo.
echo ============================================
echo    ### EXECUTAR SEMPRE EM MODO ADMINISTRADOR ###
echo ============================================
:: Configuração dinâmica de pastas
:selecionar_origem
echo.
echo ============================================
echo    SELECIONE A PASTA DE ORIGEM
echo ============================================
set /p origem="Cole o caminho da pasta: "
if not exist "!origem!\" (
    echo [ERRO] Pasta inválida! Tente novamente.
    goto selecionar_origem
)

:selecionar_destino
echo.
echo ============================================
echo    SELECIONE A PASTA DE DESTINO
echo ============================================
set /p destino="Cole o caminho da pasta: "
if not exist "!destino!\" (
    echo.
    set /p criar="Pasta não existe. Criar? (S/N): "
    if /i "!criar!"=="S" (
        mkdir "!destino!"
        echo Pasta criada: !destino!
    ) else (
        goto selecionar_destino
    )
)

:: Gera logs com timestamp
set timestamp=%date:~-4,4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%
set log="C:\backup_!timestamp!.log"
set log_detalhado="C:\backup_detalhes_!timestamp!.log"

cls
echo.
echo ============================================
echo    BACKUP INTERATIVO - (/E /XO) (Conservador - Sem exclusoes)
echo ============================================
echo [%time%] Inicio da configuracao
echo Origem:    !origem!
echo Destino:   !destino!
echo.

:: Confirmação
set /p confirmar="Confirmar backup? (S/N): "
if /i "!confirmar!" neq "S" (
    echo [CANCELADO] Operacao abortada.
    pause
    exit /b
)

:: Medição do tempo
set start_time=%time%
echo.
echo [%time%] Backup iniciado...

:: Execução principal
robocopy "!origem!" "!destino!" /E /XO /ZB /R:1 /W:1 /LOG:!log! /TEE /NP /TS /FP /XD "~*" "*.tmp"

:: Cálculo da duração
call :calcular_tempo !start_time! %time% duracao

:: Log detalhado
echo. > !log_detalhado!
echo RELATORIO COMPLETO - !date! !time! >> !log_detalhado!
echo Duracao: !duracao! >> !log_detalhado!
echo ========================================= >> !log_detalhado!
findstr /i /c:"New File" !log! >> !log_detalhado!
findstr /i /c:"Older" !log! >> !log_detalhado!

:: Resumo
echo.
echo ============ RESUMO DA OPERACAO ============
echo [DURACAO] !duracao!
echo.
for /f "tokens=1-4 delims=: " %%A in ('findstr /i "Copied Skipped Failed" !log!') do (
    echo [%%A] %%B arquivos
)
echo.
echo Log Completo:   !log!
echo Log Detalhado:  !log_detalhado!
echo ===========================================
pause
exit /b

:calcular_tempo
setlocal
set start=%~1
set end=%~2

:: Converte tempos para segundos
for /f "tokens=1-4 delims=:.," %%a in ("!start!") do (
    set /a start_s=%%a*3600 + %%b*60 + %%c
)
for /f "tokens=1-4 delims=:.," %%a in ("!end!") do (
    set /a end_s=%%a*3600 + %%b*60 + %%c
)

:: Calcula diferença
set /a diff_s=end_s - start_s
set /a hh=diff_s/3600
set /a mm=(diff_s %% 3600)/60
set /a ss=diff_s %% 60

:: Formata saída
if !hh! lss 10 set hh=0!hh!
if !mm! lss 10 set mm=0!mm!
if !ss! lss 10 set ss=0!ss!
endlocal & set %3=%hh%:%mm%:%ss%
goto :eof