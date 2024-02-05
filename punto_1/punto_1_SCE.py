"""
DataKnow Technical test

autor: Sebastian Carmona Estrada
"""
import numpy as np
import pandas as pd

def custom_parser(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        temp_dict = {}
        temp_dict["Agente"] = []
        temp_dict["Planta"] = []
        for h in np.arange(1,25):
            temp_dict["Hora_{h}".format(h=h)] = []

        for row in file:
            if not row.isspace():
                if row.find("AGENTE") != -1:
                    agent = row.split(":")[1].strip()
            
                elif 'agent' in locals():
                    if row.split(",")[1].strip() == 'D':
                        temp_dict["Agente"].append(agent)
                        temp_dict["Planta"].append(row.split(',')[0].strip())

                        for h in np.arange(1,25):
                            temp_dict["Hora_{h}".format(h=h)].append(row.split(',')[int(h + 1)].strip())

        
        return pd.DataFrame(temp_dict)

def main():
    df = custom_parser(r"punto_1\OFEI1204.txt")
    df.to_excel(r"punto_1\resultado.xlsx")
    print(df)

if __name__ == "__main__":
    main()