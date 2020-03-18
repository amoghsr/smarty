from kmodes.kmodes import KModes
from sklearn import preprocessing
import pandas as pd
import numpy as np
import warnings
warnings.filterwarnings('ignore')


def predict(filename):
    # Data Preprocessing
    data = pd.read_csv(filename)
    # Data Filtering
    exclude_list = ["Living_Room Exhaust_Fan", "Living_Room Water_Heater", "Living_Room Faucet", "Living_Room Refrigerator", "Living_Room Baby_Monitor", "Bedroom Exhaust_Fan", "Bedroom Water_Heater", "Bedroom Faucet", "Bedroom Refrigerator",
                    "Bathroom Refrigerator", "Bathroom Baby_Monitor", "Bathroom AC", "Bathroom TV", "Bathroom Speaker", "Playroom Exhaust_Fan", "Playroom Faucet", "Playroom Refrigerator",  "Playroom Water_Heater",  "Kitchen Baby_Monitor", "Kitchen TV", "Kitchen Speaker"]
    for i in range(5):
        for j in exclude_list:
            data = data[~data['routine_info_' +
                              str(i+1)].astype(str).str.contains(j, na=False)]
    data['routine_data'] = data[data.columns[2:]].apply(
        lambda x: ','.join(x.dropna().astype(str)),
        axis=1
    )
    data = data.drop(['routine_info_1', 'routine_info_2',
                      'routine_info_3', 'routine_info_4', 'routine_info_5'], axis=1)
    # Data Encoding
    oe = preprocessing.OrdinalEncoder()
    data = oe.fit_transform(data)

    # Performing KModes Clustering
    km_cao = KModes(n_clusters=2, init="Cao", n_init=1, verbose=1)
    fitClusters_cao = km_cao.fit_predict(data)

    # Converts the predictions into a dataframe
    clusterCentroidsDf = pd.DataFrame(km_cao.cluster_centroids_)

    # Gets the original data from the encoding
    inverse = pd.DataFrame(oe.inverse_transform(clusterCentroidsDf))

    # Splits the columns using delimiter ,
    result = inverse[2].str.split(",", expand=True)

    # Formats the output table
    result.insert(0, "start_time", inverse[0], True)
    result.insert(1, "end_time", inverse[1], True)

    # Renames the columns
    for i in range(0, 5):
        result.rename(columns={i: 'routine_info_'+str(i+1)}, inplace=True)

    # Writes the predicted output to a file
    result.to_csv("predicted_routines.csv", encoding="utf-8", index=False)
    return result


# Calls predict function
predict('routines.csv')
