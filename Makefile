.PHONY: force

source := ${resume}
target != basename -s.markdown ${resume}
target != basename -s.mdown ${target}
target != basename -s.mkdn ${target}
target != basename -s.mkd ${target}
target != basename -s.mdwn ${target}
target != basename -s.md ${target}

target := $(addsuffix .pdf, ${target})
date_build != date '+%d.%m.%y'
variables_storage := ./variables.yaml

${target}: variables.yaml ${source}
	pandoc \
	${source} \
	--output=${target} \
	--variable=papersize:A4 \
	--variable=mainfont:'LiberationSans-Regular.ttf' \
	--variable=mainfontoptions:BoldFont='LiberationSans-Bold.ttf' \
	--variable=mainfontoptions:ItalicFont='LiberationSans-Italic.ttf' \
	--variable=colorlinks \
	--variable=linkstyle:bold \
	--variable=urlcolor:NavyBlue \
	--variable=geometry:margin=1in \
	--pdf-engine=xelatex \
	--filter=pandoc-mustache

${variables_storage}: force
	echo "\"date_build\": ${date_build}" >${variables_storage}

force:
