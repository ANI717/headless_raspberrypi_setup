import argparse
import getpass
import os


JUPYTER_SERVICE_TEMPLATE = """
[Unit]
Description=Jupyter Notebook Service

[Service]
Type=simple
PIDFile=/run/jupyter.pid
ExecStart=/bin/bash -c "/usr/local/bin/jupyter-lab --ip="0.0.0.0" --no-browser --notebook-dir=%s"
User=pi
Group=pi
WorkingDirectory=%s
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
"""


JUPYTER_SERVICE_NAME = 'ani_jupyter'


def get_jupyter_service(working_directory):
    assert(os.path.isdir(working_directory))
    working_directory='/home/pi/'
    notebook_directory='/home/pi/'
    service_str = JUPYTER_SERVICE_TEMPLATE % (notebook_directory, working_directory)
    return service_str


if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--working_directory',
        type=str,
        help='The directory for Jupyter Lab',
        default=os.path.expanduser('~'))
    parser.add_argument('--output', default='ani717_jupyter.service')
    args = parser.parse_args()

    with open(args.output, 'w') as f:
        f.write(get_jupyter_service(args.working_directory))
