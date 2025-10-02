# 🔄 Script Batch - Backup Interativo com Relatório

Um script em lote (`.bat`) para backup conservador que transfere apenas arquivos novos e mais recentes, mantendo a integridade dos dados existentes.

## 📋 Descrição

Script automatizado de backup que utiliza ROBOCOPY para sincronização inteligente entre pastas. Copia apenas arquivos novos (`/XO`) e mais recentes, preservando a estrutura completa (`/E`) sem excluir arquivos no destino.

## ⚠️ Requisitos de Execução

**Executar sempre como Administrador** para garantir permissões adequadas de acesso e cópia de arquivos.

## 🚀 Como Usar

### Execução do Script

1. **Executar como Administrador**
   - Clique com botão direito → "Executar como administrador"

2. **Configurar Pastas**
   ============================================
SELECIONE A PASTA DE ORIGEM
============================================
Cole o caminho da pasta: [INSERIR CAMINHO ORIGEM]

============================================
SELECIONE A PASTA DE DESTINO
============================================
Cole o caminho da pasta: [INSERIR CAMINHO DESTINO]


3. **Confirmação**
- Digite `S` para confirmar o backup
- Digite `N` para cancelar

### Fluxo do Processo

1. **Validação de Pastas**
- Verifica existência da pasta origem
- Oferece criação automática da pasta destino se não existir

2. **Execução do Backup**
- Cópia conservadora (sem exclusões)
- Apenas arquivos novos e mais recentes
- Mantém estrutura completa de diretórios

3. **Geração de Relatórios**
- Log completo com timestamp
- Relatório detalhado com arquivos transferidos
- Estatísticas e tempo de execução

## 📊 Saída e Relatórios

### Arquivos Gerados
- `C:\backup_AAAAMMDD_HHMM.log` - Log completo da operação
- `C:\backup_detalhes_AAAAMMDD_HHMM.log` - Relatório filtrado

### Exemplo de Resumo
============ RESUMO DA OPERACAO ============
[DURACAO] 00:15:23

[Copied] 147 arquivos
[Skipped] 892 arquivos
[Failed] 0 arquivos

Log Completo: C:\backup_20241215_1430.log
Log Detalhado: C:\backup_detalhes_20241215_1430.log
===========================================


## ⚙️ Parâmetros ROBOCOPY

| Parâmetro | Descrição |
|-----------|-----------|
| `/E` | Copia subdiretórios incluindo vazios |
| `/XO` | Exclui arquivos mais antigos (copia apenas novos/atualizados) |
| `/ZB` | Usa modo backup e reinicia em caso de falha |
| `/R:1` | Apenas 1 tentativa de repetição |
| `/W:1` | Aguarda 1 segundo entre tentativas |
| `/LOG` | Gera arquivo de log detalhado |
| `/TEE` | Exibe saída no console e no log |
| `/NP` | Não mostra progresso porcentual |
| `/TS` | Inclui timestamps no log |
| `/FP` | Mostra caminhos completos dos arquivos |
| `/XD` | Exclui diretórios temporários e arquivos ~ |

## 🔧 Funcionalidades

### ✅ Recursos Principais
- Backup conservador (não exclui arquivos no destino)
- Cópia apenas de arquivos novos e atualizados
- Criação automática de pasta destino
- Timestamp em todos os logs
- Medição precisa do tempo de execução
- Interface interativa com confirmações

### ✅ Tratamento de Erros
- Validação de caminhos
- Confirmação antes da execução
- Tentativas de repetição controladas
- Logs detalhados para troubleshooting

## 🛠️ Personalização

### Localização dos Logs
Editar a linha:
```batch
set log="C:\backup_!timestamp!.log"
