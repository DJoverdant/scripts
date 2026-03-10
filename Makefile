VENV ?= .venv
PIP = $(VENV)/bin/pip
PY = $(VENV)/bin/python

.PHONY: init
init: $(VENV)
	$(PIP) install --upgrade pip
	$(PIP) install mbake
	$(PIP) install black

$(VENV):
	python3 -m venv $(VENV)
	touch $@

.PHONY: format
format:
	chmod +x */*.sh
	$(VENV)/bin/mbake format Makefile

.PHONY: database
database:
	sh database/create.sh