# 创建项目参考文章：
#【Docker+Python+Flask】https://qiita.com/Pitts7/items/542196eaec6bc0b77c38

FROM python:3.8

WORKDIR /

ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

COPY requirements.txt ./

RUN pip install --upgrade pip
RUN pip install --upgrade setuptools
RUN pip install -r requirements.txt

COPY . .
CMD ["flask", "run"]
