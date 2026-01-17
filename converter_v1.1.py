import pandas as pd
import json

print("--- Gerando JSON para Stitch v1.1 ---")

try:
    # Nota: Agora ele lê a versão v1.1 gerada no passo anterior
    df = pd.read_csv('Tabela_suturas_v1.1.csv', sep=';', on_bad_lines='skip', encoding='utf-8')
except FileNotFoundError:
    print("Erro: Arquivo 'Tabela_suturas_v1.1.csv' não encontrado. Rode o script de merge primeiro.")
    exit()

# Função auxiliar para limpar NaN (vazios)
def clean_str(val):
    return str(val).strip() if pd.notna(val) else ""

# Função para agrupar concorrentes JJ em uma lista
def agrupar_concorrentes(row):
    cols = ['Conc. JJ Ref 1', 'Conc. JJ Ref 2', 'Conc. JJ Ref 3', 'Conc. JJ Ref 4']
    # Cria uma lista apenas com os valores que existem (não são vazios)
    return [clean_str(row[c]) for c in cols if pd.notna(row[c]) and clean_str(row[c]) != ""]

json_data = []

for _, row in df.iterrows():
    item = {
        "id": clean_str(row['Código']), # Usando o código como ID único se necessário
        "codigo": clean_str(row['Código']),
        "codigoBioline": clean_str(row['codigo_bioline']), # NOVO CAMPO
        "familia": clean_str(row['Família']),
        "subtipo": clean_str(row['Subtipo']),
        "descricao": clean_str(row['Descrição']),
        "especialidade": clean_str(row['Especialidade']),
        
        # Lista de concorrentes (Ethicon)
        "concorrentesJJ": agrupar_concorrentes(row),
        
        "diametro": clean_str(row['Diâmetro']),
        "comprimento": clean_str(row['Comprimento Fio']),
        "tipoAgulha": clean_str(row['Tipo']),
        "codAgulha": clean_str(row['Cod. Agulha']),
        "curvatura": clean_str(row['Curv']),
        "tamanhoAgulha": clean_str(row['Tamanho Agulha']),
        "rms": clean_str(row['RMS']),
        "descricaoLicitacao": clean_str(row['Descrição para Licitação']),
        "composto": clean_str(row['Composto']),
        "nomeConcorrente": clean_str(row['NomeConcorrente'])
    }
    json_data.append(item)

# Salva o JSON final
with open('suturas.json', 'w', encoding='utf-8') as f:
    json.dump(json_data, f, ensure_ascii=False, indent=4)

print(f"Arquivo 'suturas.json' atualizado com {len(json_data)} itens!")
