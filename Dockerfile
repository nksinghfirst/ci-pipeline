FROM python:3.9-slim
ADD app.py /
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
EXPOSE 3333
CMD [ "python", "./app.py"]

