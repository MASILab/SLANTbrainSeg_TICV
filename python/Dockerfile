FROM python:3.6

#ADD train.py /
COPY . /slant_bids_app

RUN make /slant_bids_app

RUN pip3 install torch
RUN pip3 install pytz
RUN pip3 install scipy
RUN pip3 install nibabel
RUN pip3 install tqdm

ENTRYPOINT [ "python", "./slant_bids_app/test.py" ]
