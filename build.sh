#/bin/bash
unset SED 

catchErr () {
	ERROR=$?
	if [ $ERROR != 0 ]
	then
		echo "Irgendetwas stimmt mit Hasi nicht. Beende Kompilierungsprozess, Exitstatus $ERROR."
		exit $ERROR;
	fi
}

Targets='ar71xx-generic ar71xx-nand mpc85xx-generic x86-generic x86-kvm_guest x86-64 x86-xen_domu ramips-rt305x brcm2708-bcm2708 brcm2708-bcm2709 sunxi'
FirstBranch='testing'
BrokenBranches='experimental'
UnBrokenBranches='beta stable'

Doms='1 8'

sed s/---BRANCH---/experimental/ site/site.conf.template >site/site.conf &&\

for Target in $Targets
do
	make -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/'$FirstBranch GLUON_BRANCH=$FirstBranch GLUON_TARGET=$Target V=s | tee log-$Target.log 
	catchErr
	make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/'$FirstBranch GLUON_BRANCH=$FirstBranch GLUON_TARGET=$Target
	catchErr
done

# Images

for Branch in $BrokenBranches
do
	sed s/---BRANCH---/$Branch/ site/site.conf.template >site/site.conf &&\
	for Target in $Targets
	do
		make -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/'$Branch GLUON_BRANCH=$Branch GLUON_TARGET=$Target
		catchErr
		make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/'$Branch GLUON_BRANCH=$Branch GLUON_TARGET=$Target
		catchErr
	done
done

for Branch in $UnBrokenBranches
do
	sed s/---BRANCH---/$Branch/ site/site.conf.template >site/site.conf &&\
	for Target in $Targets
	do
		make -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/'$Branch GLUON_BRANCH=$Branch GLUON_TARGET=$Target
		catchErr
		make manifest -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/'$Branch GLUON_BRANCH=$Branch GLUON_TARGET=$Target
		catchErr
	done
done

# Domänen

for Dom in $Doms
do
	for Branch in $FirstBranch $BrokenBranches
	do
		sed s/---BRANCH---/$Branch/ site/site.conf.$Dom.template >site/site.conf &&\
		for Target in $Targets
		do
			make -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/'dom$Dom/$Branch GLUON_BRANCH=$Branch GLUON_TARGET=$Target
			catchErr
			make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/'dom$Dom/$Branch GLUON_BRANCH=$Branch GLUON_TARGET=$Target
			catchErr
		done
	done

	for Branch in $UnBrokenBranches
	do
		sed s/---BRANCH---/$Branch/ site/site.conf.$Dom.template >site/site.conf &&\
		for Target in $Targets
		do
			make -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/'dom$Dom/$Branch GLUON_BRANCH=$Branch GLUON_TARGET=$Target
			catchErr
			make manifest -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/'dom/$Dom/$Branch GLUON_BRANCH=$Branch GLUON_TARGET=$Target
			catchErr
		done
	done
done

echo FERTIG!!!