import pandas as pd
import json

# Carrega o CSV que você me enviou
df = pd.read_csv('Tabela suturas.csv')

# Função para agrupar os códigos dos concorrentes
def agrupar_concorrentes(row):
    cols = ['Conc. JJ Ref 1', 'Conc. JJ Ref 2', 'Conc. JJ Ref 3', 'Conc. JJ Ref 4']
    return [str(row[c]) for c in cols if pd.notna(row[c])]

# Criando a estrutura para o app
json_data = []
for _, row in df.iterrows():
    item = {
        "codigo": str(row['Código']),
        "familia": str(row['Família']),
        "subtipo": str(row['Subtipo']),
        "descricao": str(row['Descrição']),
        "especialidade": str(row['Especialidade']),
        "concorrentes": agrupar_concorrentes(row),
        "diametro": str(row['Diâmetro']),
        "comprimento": str(row['Comprimento Fio']),
        "tipoAgulha": str(row['Tipo']),
        "codAgulha": str(row['Cod. Agulha']),
        "curvatura": str(row['Curv']),
        "tamanhoAgulha": str(row['Tamanho Agulha']),
        "rms": str(row['RMS']),
        "descricaoLicitacao": str(row['Descrição para Licitação'])
    }
    json_data.append(item)

# Salva o arquivo final
with open('suturas.json', 'w', encoding='utf-8') as f:
    json.dump(json_data, f, ensure_ascii=False, indent=4)

print("Arquivo suturas.json gerado com sucesso!")
