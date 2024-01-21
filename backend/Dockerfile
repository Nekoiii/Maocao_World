# 创建项目参考文章：
#【Docker+Python+Flask】https://qiita.com/Pitts7/items/542196eaec6bc0b77c38

FROM python:3.8

WORKDIR /app


ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

COPY requirements.txt ./

RUN pip install --upgrade pip
RUN pip install --upgrade setuptools
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app
# CMD ["flask", "run"]
CMD python app.py
