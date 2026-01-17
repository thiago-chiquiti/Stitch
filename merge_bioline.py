import pandas as pd
import numpy as np # Importante para tratar nulos reais

print("--- Fusão de Dados Stitch v1.2 (Correção 'nan') ---")

# 1. Carrega CSV Principal
try:
    main_df = pd.read_csv('Tabela suturas.csv', sep=';', encoding='utf-8', dtype=str)
    print(f"Main CSV: {len(main_df)} linhas")
except Exception as e:
    print(f"Erro no Main: {e}")
    exit()

# 2. Carrega CSV Bioline (Google Sheets)
try:
    bioline_df = pd.read_csv('Bioline.csv', sep=',', header=None, dtype=str,
                             names=['codigo_bioline', 'desc_bio', 'codigo_medtronic', 'codigo_ethicon', 'unidades'])
    print(f"Bioline CSV: {len(bioline_df)} linhas")
except Exception as e:
    print(f"Erro no Bioline: {e}")
    exit()

# --- LIMPEZA CRÍTICA (A CORREÇÃO DO PROBLEMA) ---
# Função para limpar sujeira e garantir que vazio seja realmente VAZIO
def limpar_chave(valor):
    if pd.isna(valor): return None
    s = str(valor).strip().upper()
    if s in ["", "NAN", "NONE", "NULL", "-"]: # Lista negra de valores inválidos
        return None
    return s

# Aplica limpeza nas chaves de busca
bioline_df['clean_medtronic'] = bioline_df['codigo_medtronic'].apply(limpar_chave)
bioline_df['clean_ethicon'] = bioline_df['codigo_ethicon'].apply(limpar_chave)
main_df['clean_codigo'] = main_df['Código'].apply(limpar_chave)

# 3. Criação dos Dicionários (Só entra se a chave NÃO for None)
# Dropna garante que não criaremos a regra "Vazio = BMPL35..."
map_medtronic = bioline_df.dropna(subset=['clean_medtronic']).set_index('clean_medtronic')['codigo_bioline'].to_dict()
map_ethicon = bioline_df.dropna(subset=['clean_ethicon']).set_index('clean_ethicon')['codigo_bioline'].to_dict()

print(f"Regras de mapeamento Medtronic válidas: {len(map_medtronic)}")
print(f"Regras de mapeamento Ethicon válidas: {len(map_ethicon)}")

# 4. Cruzamento Seguro
main_df['codigo_bioline'] = main_df['clean_codigo'].map(map_medtronic)

def preencher_lacunas_seguro(row):
    # Se já achou via Medtronic, mantém
    val_atual = row['codigo_bioline']
    if pd.notna(val_atual) and str(val_atual).strip() != "":
        return val_atual
    
    # Busca nos concorrentes
    cols_concorrentes = ['Conc. JJ Ref 1', 'Conc. JJ Ref 2', 'Conc. JJ Ref 3', 'Conc. JJ Ref 4']
    for col in cols_concorrentes:
        chave = limpar_chave(row[col]) # Limpa a chave antes de buscar
        if chave and chave in map_ethicon:
            return map_ethicon[chave]
            
    return "" # Se não achou nada, retorna VAZIO e não um código aleatório

main_df['codigo_bioline'] = main_df.apply(preencher_lacunas_seguro, axis=1)

# 5. Salvar
# Remove colunas temporárias
main_df.drop(columns=['clean_codigo'], inplace=True)
main_df.to_csv('Tabela_suturas_v1.1.csv', sep=';', index=False, encoding='utf-8')

print("\nSUCESSO! Tabela corrigida gerada.")
# Verificação final: Quantas linhas têm código Bioline agora?
total_preenchido = main_df['codigo_bioline'].replace("", np.nan).notna().sum()
print(f"Total de correspondências reais encontradas: {total_preenchido}")