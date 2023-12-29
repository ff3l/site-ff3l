GLUON_MULTIDOMAIN=1

GLUON_DEPRECATED ?= upgrade

GLUON_REGION ?= eu

GLUON_ATH10K_MESH ?= 11s

DEFAULT_GLUON_RELEASE := g$(shell git -C $(shell pwd) log --pretty=format:'%h' -n 1)+s$(shell git -C $(shell pwd)/site log --pretty=format:'%h' -n 1)~$(shell date '+%Y%m%d')

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

GLUON_PRIORITY ?= 0

GLUON_LANGS ?= en de fr

