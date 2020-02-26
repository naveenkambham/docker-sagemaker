FROM python:3.6

# set the working directory
RUN ["mkdir", "app"]
WORKDIR "app"

# install code dependencies
COPY "requirements.txt" .
RUN ["pip", "install", "-r", "requirements.txt"]


COPY "app.py" .
COPY "run.sh" .
COPY "training.ipynb" .
COPY "data.csv" .

# provision environment
ENV FLASK_APP app.py
RUN ["chmod", "+x", "./run.sh"]
EXPOSE 8080
ENTRYPOINT ["./run.sh"]
CMD ["build"]
