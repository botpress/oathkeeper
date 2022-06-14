#!/bin/sh
gomplate < /.oathkeeper.tpl.yaml > /.oathkeeper.yaml && \
exec oathkeeper "$@"
