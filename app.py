from os import read
import streamlit as st
import pandas as pd

def read_data(file: str) -> pd.DataFrame:
    df = pd.read_csv(file, sep=';')
    return df

def run_app():
    st.title("Vektis opendata")
    df = read_data("Vektis Open Databestand Zorgverzekeringswet 2023 - gemeente.csv")
    st.write(df.head(20))
    gemeenten = df["gemeentenaam"].unique()
    option_gemeente = st.selectbox("Welke gemeente?", gemeenten)
    option_kosten = st.selectbox('Welke kostensoort?', df.columns)
    df_filtered = df[df["gemeentenaam"] == option_gemeente]
    st.bar_chart(data=df_filtered, x="leeftijdsklasse",y=option_kosten, color='geslacht', stack=False)



if __name__ == "__main__":
    run_app()
