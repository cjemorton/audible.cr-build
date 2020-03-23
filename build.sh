#!/usr/bin/env bash

crystal build adlink.cr --release --progress
crystal build auauth.cr --release --progress
crystal build getlibrary.cr --release --progress
crystal build auget.cr --release --progress
