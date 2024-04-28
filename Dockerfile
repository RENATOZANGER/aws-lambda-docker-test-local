FROM python:3.12

RUN apt-get update && apt-get install -y wget unzip && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install o Google Chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && apt-get install -y google-chrome-stable && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install AWS Lambda Runtime Interface Emulator (RIE)
RUN curl -Lo /usr/local/bin/aws-lambda-rie https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/latest/download/aws-lambda-rie && \
    chmod +x /usr/local/bin/aws-lambda-rie

COPY main.py ./
COPY requirements.txt ./
RUN python3 -m pip install -r requirements.txt

ENTRYPOINT [ "/usr/local/bin/aws-lambda-rie", "/usr/local/bin/python", "-m", "awslambdaric" ]
CMD [ "main.lambda_handler" ]
