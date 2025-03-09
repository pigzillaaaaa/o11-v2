FROM public.ecr.aws/lts/ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        software-properties-common \
        wget \
        gnupg \
        lsb-release \
        curl \
        tzdata \
        nano

RUN apt install python3 python3-pip -y

RUN pip install urllib3 dnspython requests requests_toolbelt --break-system-packages
      
RUN add-apt-repository ppa:ubuntuhandbook1/ffmpeg7 && \
    apt-get update

RUN apt install ffmpeg -y
    
RUN mkdir -p /home/o11
RUN mkdir -p /home/o11/hls/live /home/o11/hls/replay /home/o11/dl/tmp /home/o11/scripts /home/o11/logs /home/o11/rec
RUN chmod -R 755 /home/o11

WORKDIR /home/o11

COPY files/o11v22b1 /home/o11/
COPY files/run.sh /home/o11/
COPY files/o11.py /home/o11/scripts/

RUN chmod 755 /home/o11/run.sh
RUN chmod 755 /home/o11/o11v22b1

CMD ["/home/o11/run.sh"]
