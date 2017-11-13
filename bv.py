import numpy as np
import os
from glob import glob
import sys



def time_to_ssm(x):
    x = pd.DataFrame(x)
    date = x.index.map(lambda d: d.year * 10000 + d.month * 100 + d.day).values
    ssm = x.index.map(lambda t: t.hour * 3600 + t.minute * 60 + t.second + t.microsecond / 1e6).values
    x.insert(0, "Date", date)
    x.insert(1, "SSM", ssm)
    x.reset_index(drop=True)
    return x


M = 300
        rp = data_unique.resample(str(M) + "s", closed="right", label="right").last()
        if T == 86400:
            rp = pd.concat((rp.iloc[:-1], data_unique.iloc[-1:]))
        cts_returns = np.log(rp.ffill()).diff().iloc[1:]

rbv = np.sqrt(np.pi / 2 * 1 / (T / M - 1) * (cts_returns.abs() * cts_returns.shift().abs()).sum())
