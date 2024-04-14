FROM python:3.9-slim
ADD app.py /
RUN pip install flask
RUN pip install flask_restful
EXPOSE 3333
CMD [ "python", "./app.py"]
