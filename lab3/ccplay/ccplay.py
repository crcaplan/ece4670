#!/usr/bin/python

import argparse
import hashlib
import random
import os
import sys
import time
import wave

try:
    import requests
except ImportError:
    requests_dir = os.path.abspath(os.path.dirname(__file__))
    libs_dir = os.path.join(requests_dir, 'libs_ccplay')
    sys.path.append(libs_dir)
    import requests

__version__ = "2.0.101"

DEFAULT_SERVER='commcloud.cac.cornell.edu'
DEFAULT_PORT=46702
VALID_BIT_DEPTH_SET = set([8, 16, 24])
VALID_SAMPLE_RATE_SET = set([8000, 44100, 96000, 192000])
MAX_CHANNEL_NUMBER = 1
MAX_DURATION_SECONDS = 90.0


def check_wave_file(fname):
    wav_info = None
    try:
        filelength = os.path.getsize(fname)
        wav_read_file = wave.open(fname, 'rb')
        wav_info = {
                'channels'  : wav_read_file.getnchannels(),
                'bitdepth'  : wav_read_file.getsampwidth()*8,
                'samplerate' : wav_read_file.getframerate(), 
                'framenum'  : wav_read_file.getnframes()
                }

        # Don't use getnframes to get number of samples, it gives
        # incorrect answers in some cases. Note that this only gives
        # the approximate duration of the file because it counts the
        # header bytes as audio samples.

        wav_info['time'] = (filelength/(float(wav_info['samplerate'])*
                            float(wav_info['bitdepth'])*
                            float(wav_info['channels'])/8))
        wav_read_file.close()

        if wav_info['bitdepth'] not in VALID_BIT_DEPTH_SET:
            return (False,
                    ("ERROR: %i is not an acceptable sample bit depth. " +
                     "Only %s are allowed ") %
                            (wav_info['bitdepth'] , VALID_BIT_DEPTH_SET),
                    wav_info)
        if wav_info['samplerate'] not in VALID_SAMPLE_RATE_SET:
            return (False,
                    ("ERROR: %i is not an acceptable sample rate. Only %s " +
                     "are allowed ") %
                            (wav_info['samplerate'], VALID_SAMPLE_RATE_SET),
                    wav_info)
        if wav_info['channels'] > MAX_CHANNEL_NUMBER:
            return (False, "ERROR: Audio is not single channel (mono).", wav_info)
        if wav_info['time'] > MAX_DURATION_SECONDS:
            return (False, "ERROR: WAV file appears to be too long.", wav_info)
    except:
        return (False, "ERROR: WAV file is invalid.", wav_info)
    return (True, "WAV File OK", wav_info)


def send(args):
    wav_file = open(args.wav_input, 'rb')
    wav_contents = wav_file.read()
    wav_file.close()
    (continue_flag, check_msg, wav_info) = check_wave_file(args.wav_input)
    print(check_msg)
    if not continue_flag:
        exit(1)
    data_md5 = hashlib.md5(wav_contents).hexdigest()
    files = {'wav-payload' : wav_contents}
    data = {'md5sum' : data_md5}
    data['version'] = "%(prog)s {version}".format(version=__version__)
    if args.prepause:
        data['prepause'] = str(args.prepause[0])
    if args.postpause:
        data['postpause'] = str(args.postpause[0])
    if args.channel:
        data['channel'] = str(args.channel)
    if args.rate:
        data['record_rate'] = str(args.rate)
    else:
        data['record_rate'] = str(wav_info['samplerate'])
    if args.depth:
        data['record_bitdepth'] = str(args.depth)
    else:
        data['record_bitdepth'] = str(wav_info['bitdepth'])

    print("Connecting to server ... ")
    url_addr = 'http://' + DEFAULT_SERVER + ':' + str(DEFAULT_PORT)

    try_count = 1
    max_tries = 5
    while (try_count < max_tries):
        try_count = try_count + 1
        try:
            req = requests.post(url_addr, data=data, files=files)
            print("received response.")
            print(req.headers['Response-Msg'])
            with open(args.wav_output, 'wb') as wav_out:
                wav_out.write(req.content)
            print(args.wav_output + " saved")
            return
        except requests.exceptions.ConnectionError:
            print("Could not connect to server. Retrying time # %i." % try_count)
            time.sleep((2 ** try_count) + (random.randint(0, 1000) / 1000))
            continue
    print("Could not connect to server after %i tries. Exiting." % try_count)


def generate_parser():
    parser = argparse.ArgumentParser(
        description="Apply remote analog channel to a given .wav file")
    parser.add_argument(
        'wav_input',
        help="an input .wav file to be sent through the remote channel")
    parser.add_argument('wav_output',
        help=("the name of the file you would like the output .wav file to be " +
              "saved as"))
    parser.add_argument('--version', action='version',
        version='%(prog)s {version}'.format(version=__version__))
    parser.add_argument(
        '--prepause', nargs=1, type=float,
        help=("a time (in seconds) to pause while recording before the file " +
              "is played"))
    parser.add_argument(
        '--postpause', nargs=1, type=float,
        help=("a time (in seconds) to pause while recording after the file " +
              "is played"))
    parser.add_argument(
        '--channel',
        help=("a channel specifier; options are 'audio0' and 'audio1'; " +
              "if none is specified then a channel with the shortest queue " +
              "will be used"))
    parser.add_argument(
        '--rate', nargs=1, type=int,
        help=("sampling rate, in Hz, at which to record the output .wav file; " +
              "options are 8000, 44100, 96000, and 192000; if " +
              "not specified, the sampling rate of the input .wav file is used"))
    parser.add_argument(
        '--depth', nargs=1, type=int,
        help=("resolution, in bits-per-sample, at which to record the output " +
              ".wav file; options are 8, 16, 24; if not specified, the depth " +
              "of the input .wav file is used"))
    return parser
    

if __name__ == "__main__":
    arg_parser = generate_parser()
    send(arg_parser.parse_args())


