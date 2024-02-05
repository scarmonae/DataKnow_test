"""
DataKnow Technical test

autor: Sebastian Carmona Estrada
"""
import pdb
import numpy as np
import pandas as pd

def excel_parser(file_path):
    columns = ['Nombre visible Agente', 'AGENTE (OFEI)', 'CENTRAL (OFEI)', 'Tipo de central (Hidro, Termo, Filo, Menor)']

    ds = pd.read_excel(file_path, sheet_name="Master Data Oficial", usecols=columns)
    ds = ds[(ds['Nombre visible Agente'] == 'EMGESA') & ((ds['Tipo de central (Hidro, Termo, Filo, Menor)'] == 'H') | (ds['Tipo de central (Hidro, Termo, Filo, Menor)'] == 'T')) ] 
    
    return ds


def txt_parser(file_path):
    columns = ['Hora_{h}'.format(h=h) for h in np.arange(1, 25)]
    columns.insert(0, 'CENTRAL (OFEI)')

    ds = pd.read_csv(file_path, encoding='ISO-8859-1', header=None)
    ds.columns = columns

    return ds

def merge_datasets(ds1, ds2):
    ds = pd.merge(ds1, ds2, on='CENTRAL (OFEI)')

    return ds

def sum_h(ds):
    ds['Total'] = ds.iloc[:, -24:].sum(axis=1)
    ds = ds[ds['Total'] > 0]
    return ds  


def main():
    ds1 = excel_parser(r"punto_2\Datos Maestros VF.xlsx")
    ds2 = txt_parser(r'punto_2\dDEC1204.TXT')
    ds_merged = merge_datasets(ds1=ds1, ds2=ds2)
    ds_sumado = sum_h(ds_merged)

    ds_sumado.to_excel(r'punto_2\Resultado.xlsx')
    # pdb.set_trace()



if __name__ == "__main__":
    main()