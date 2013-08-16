#!/bin/sh

# Copyright 2013 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS-IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

##########################################################################

# INSTRUCTIONS:                                                          
#                                                                        
# Run this script from the oppia root folder:
#   bash scripts/django_testrunner.sh
# The root folder MUST be named 'oppia'.
# It installs dependencies in a virtualenv and runs django tests.

if [ -z "$BASH_VERSION" ]
then
  echo ""
  echo "  Please run me using bash: "
  echo ""
  echo "     bash scripts/django_testrunner.sh"
  echo ""
  exit 1
fi

echo Installing dependencies in virtual python environment. 
type virtualenv >/dev/null 2>&1 || { 
echo "Virtualenv is required but it's not installed. Aborting."; exit 1; }

virtualenv ../venv
source ../venv/bin/activate
pip install -r requirements.txt -q || {
	echo "pip failed to install the dependencies. Aborting";
	echo "If lxml is failing to install, make sure you have libxml2-dev and libxslt-dev installed."
	exit 1;
}

python ./core/tests/django_suite.py
