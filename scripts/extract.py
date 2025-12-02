import os
import pandas as pd

files = os.listdir("Datasets")
tables = {'user_job':[], 'user_data':[], 'staff_data':[], 'order_data':[], 'order_delays':[], 'product_list':[], 'merchant_data':[], 'campaign_data':[], 'user_credit_card':[], 'line_item_data_prices':[], 'line_item_data_products':[], 'order_with_merchant_data':[], 'transactional_campaign_data':[]}

for table in tables:
    while files:
        filename = files.pop()
        for table in tables:
            if filename.startswith(table):
                tables[table] += [filename]

def read(file):
    file = os.path.join("Datasets", file)
    if 'csv' in file:
        df = pd.read_csv(file, sep=None, engine='python')
    elif 'json' in file:
        df = pd.read_json(file)
    elif 'pickle' in file:
        df = pd.read_pickle(file)
    elif 'xlsx' in file:
        df = pd.read_excel(file)
    elif 'html' in file:
        df = pd.read_html(file)[0]
    elif 'parquet' in file:
        df = pd.read_parquet(file)
    return df

def integrate(table):
    df = read(tables[table][0])
    if len(tables[table]) > 1:
        for i in range(1, len(tables[table])):
            df = pd.concat([df, read(tables[table][i])], ignore_index=True)
    if table == "user_credit_card":
        df['credit_card_number'] = df['credit_card_number'].apply(lambda x: f'"{x}"')
    csv_path = os.path.join(os.getcwd(), f"{table}.csv")
    df.to_csv(csv_path, index=False)

for table in tables:
    integrate(table)
