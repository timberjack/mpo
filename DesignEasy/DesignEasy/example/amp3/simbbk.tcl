#!/bin/bash

((echo "load #input#") && cat) > SPICEpipe&
((echo "run") && cat) > SPICEpipe&
#sleep 1
#while [ ! -f ./#output# ]; do
#	cat >  SPICEpipe&
#	echo $! > SPICEpipe-cat-pid
#done
#echo "quit"> SPICEpipe&





