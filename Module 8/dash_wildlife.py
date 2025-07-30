# -- Instrucciones iniciales para correr este archivo en la web --
# Usa el siguiente comando desde la consola:
# pythom -m pip install setuptools packaging pandas dash
# python -m pip install httpx==0.25 dash plotly
# python3 dash_wildlife.py.
# Ingresa al navegador https://127.0.0.1:8050

import pandas as pd
import dash
from dash import html, dcc
from dash.dependencies import Input, Output, State
import plotly.graph_objects as go
import plotly.express as px
from dash import no_update
import datetime as dt
#Crear app
app = dash.Dash(__name__)
#Limpiar el diseño y no mostrar excepciones hasta que se ejecute la devolución de llamada
app.config.suppress_callback_exceptions = True
# Leer los datos de incendios forestales en un dataframe de pandas
df =  pd.read_csv('https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-DV0101EN-SkillsNetwork/Data%20Files/Historical_Wildfires.csv')
#Extraer año y mes de la columna de fecha
df['Month'] = pd.to_datetime(df['Date']).dt.month_name() #usado para los nombres de los meses
df['Year'] = pd.to_datetime(df['Date']).dt.year
#Sección de diseño de Dash
#Tarea 1 Agregar el Título al Tablero
app.layout = html.Div(children=[html.H1('Tablero de Incendios Forestales en Australia', 
                                style={'textAlign': 'center', 'color': '#503D36',
                                'font-size': 26}),
# TAREA 2: Agregar los elementos de radio y un desplegable justo debajo de la primera división interna
     #comienza la división externa
     html.Div([
                   # Primera división interna para agregar texto auxiliar del desplegable para Ruedas motrices seleccionadas
                    html.Div([
                            html.H2('Seleccionar Región:', style={'margin-right': '2em'}),

                    #Elementos de radio para seleccionar la región
                    #dcc.RadioItems(['NSW','QL','SA','TA','VI','WA'], 'NSW', id='region',inline=True)]),
                    dcc.RadioItems([{"label":"Nueva Gales del Sur","value": "NSW"},
                                    {"label":"Territorio del Norte","value": "NT"},
                                    {"label":"Queensland","value": "QL"},
                                    {"label":"Australia del Sur","value": "SA"},
                                    {"label":"Tasmania","value": "TA"},
                                    {"label":"Victoria","value": "VI"},
                                    {"label":"Australia Occidental","value": "WA"}],"NSW", id='region',inline=True)]),
                    #Desplegable para seleccionar el año
                    html.Div([
                            html.H2('Seleccionar Año:', style={'margin-right': '2em'}),
                        dcc.Dropdown(df.Year.unique(), value = 2005,id='year')
                    ]),
#TAREA 3: Agregar dos divisiones vacías para la salida dentro de la siguiente división interna. 
         #Segunda división interna para agregar 2 divisiones internas para 2 gráficos de salida
                    html.Div([
                
                        html.Div([ ], id='plot1'),
                        html.Div([ ], id='plot2')
                    ], style={'display': 'flex'}),

    ])
    #finaliza la división externa

])
#finaliza el diseño
#TAREA 4: Agregar los componentes de Salida e entrada dentro del decorador app.callback.
#Lugar para agregar el decorador @app.callback
@app.callback([Output(component_id='plot1', component_property='children'),
               Output(component_id='plot2', component_property='children')],
               [Input(component_id='region', component_property='value'),
                Input(component_id='year', component_property='value')])
#TAREA 5: Agregar la función de devolución de llamada.   
#Lugar para definir la función de devolución de llamada.
def reg_year_display(input_region,input_year):  
    #datos
   region_data = df[df['Region'] == input_region]
   y_r_data = region_data[region_data['Year']==input_year]
    #Gráfico uno - Promedio Mensual Estimado del Área de Incendios   
   est_data = y_r_data.groupby('Month')['Estimated_fire_area'].mean().reset_index()
   fig1 = px.pie(est_data, values='Estimated_fire_area', names='Month', title="{} : Promedio Mensual Estimado del Área de Incendios en el año {}".format(input_region,input_year))   
     #Gráfico dos - Promedio Mensual del Conteo de Píxeles para Incendios de Vegetación Presumidos
   veg_data = y_r_data.groupby('Month')['Count'].mean().reset_index()
   fig2 = px.bar(veg_data, x='Month', y='Count', title='{} : Conteo Promedio de Píxeles para Incendios de Vegetación Presumidos en el año {}'.format(input_region,input_year))    
   return [dcc.Graph(figure=fig1),
            dcc.Graph(figure=fig2) ]
if __name__ == '__main__':
    app.run()
