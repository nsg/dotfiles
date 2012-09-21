#!/bin/bash

echo "Press enter to deploy `dirname $0` to $HOME"
echo -n "Type ctrl-c to abort "
read

# Deploy normal files
for obj in `dirname $0`/*; do
	if [[ $obj =~ deploy.sh ]]; then continue; fi
	if [[ $obj =~ README ]]; then continue; fi
	if [[ $obj =~ ssh ]]; then continue; fi
	ln -s $obj $HOME/.`basename $obj`
done

# Deploy special filed
ln -s `dirname $0`/ssh/config $HOME/.ssh/config
