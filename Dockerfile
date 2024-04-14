FROM python:3.9-slim
ADD app.py /
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
RUN pip install flask_restful
EXPOSE 3333
CMD [ "python", "./app.py"]

