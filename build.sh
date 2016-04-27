#/bin/bash
unset SED 
make -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/experimental' GLUON_BRANCH=experimental GLUON_TARGET=ar71xx-generic V=s | tee log-ar71xx-generic.log &&\
make -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/experimental' GLUON_BRANCH=experimental GLUON_TARGET=ar71xx-nand V=s | tee log-ar71xx-nand.log &&\
make -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/experimental' GLUON_BRANCH=experimental GLUON_TARGET=mpc85xx-generic V=s | tee log-mpc85xx-generic.log &&\
make -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/experimental' GLUON_BRANCH=experimental GLUON_TARGET=x86-generic V=s | tee log-x86-generic.log &&\
make -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/experimental' GLUON_BRANCH=experimental GLUON_TARGET=x86-kvm_guest V=s | tee log-x86-kvm_guest.log &&\
make -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/experimental' GLUON_BRANCH=experimental GLUON_TARGET=x86-64 V=s | tee log-x86-64.log &&\
make -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/experimental' GLUON_BRANCH=experimental GLUON_TARGET=x86-xen_domu V=s | tee log-x86-xen_domu.log &&\
make -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/experimental' GLUON_BRANCH=experimental GLUON_TARGET=ramips-rt305x V=s | tee log-ramips-rt305x.log &&\
make -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/experimental' GLUON_BRANCH=experimental GLUON_TARGET=brcm2708-bcm2708 V=s | tee log-brcm2708-bcm2708.log &&\
make -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/experimental' GLUON_BRANCH=experimental GLUON_TARGET=brcm2708-bcm2709 V=s | tee log-brcm2708-bcm2709.log &&\
make -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/experimental' GLUON_BRANCH=experimental GLUON_TARGET=sunxi V=s | tee log-sunxi.log &&\
make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/experimental' GLUON_BRANCH=experimental GLUON_TARGET=ar71xx-generic &&\
make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/experimental' GLUON_BRANCH=experimental GLUON_TARGET=ar71xx-nand &&\
make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/experimental' GLUON_BRANCH=experimental GLUON_TARGET=mpc85xx-generic &&\
make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/experimental' GLUON_BRANCH=experimental GLUON_TARGET=x86-generic &&\
make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/experimental' GLUON_BRANCH=experimental GLUON_TARGET=x86-kvm_guest &&\
make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/experimental' GLUON_BRANCH=experimental GLUON_TARGET=x86-64 &&\
make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/experimental' GLUON_BRANCH=experimental GLUON_TARGET=x86-xen_domu &&\
make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/experimental' GLUON_BRANCH=experimental GLUON_TARGET=ramips-rt305x &&\
make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/experimental' GLUON_BRANCH=experimental GLUON_TARGET=brcm2708-bcm2708 &&\
make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/experimental' GLUON_BRANCH=experimental GLUON_TARGET=brcm2708-bcm2709 &&\
make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/experimental' GLUON_BRANCH=experimental GLUON_TARGET=sunxi &&\
make images -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/beta' GLUON_BRANCH=beta GLUON_TARGET=ar71xx-generic &&\
make images -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/beta' GLUON_BRANCH=beta GLUON_TARGET=ar71xx-nand &&\
make images -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/beta' GLUON_BRANCH=beta GLUON_TARGET=mpc85xx-generic &&\
make images -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/beta' GLUON_BRANCH=beta GLUON_TARGET=x86-generic &&\
make images -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/beta' GLUON_BRANCH=beta GLUON_TARGET=x86-kvm_guest &&\
make images -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/beta' GLUON_BRANCH=beta GLUON_TARGET=x86-64 &&\
make images -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/beta' GLUON_BRANCH=beta GLUON_TARGET=x86-xen_domu &&\
make images -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/beta' GLUON_BRANCH=beta GLUON_TARGET=ramips-rt305x &&\
make images -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/beta' GLUON_BRANCH=beta GLUON_TARGET=brcm2708-bcm2708 &&\
make images -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/beta' GLUON_BRANCH=beta GLUON_TARGET=brcm2708-bcm2709 &&\
make images -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/beta' GLUON_BRANCH=beta GLUON_TARGET=sunxi &&\
make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/beta' GLUON_BRANCH=beta GLUON_TARGET=ar71xx-generic &&\
make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/beta' GLUON_BRANCH=beta GLUON_TARGET=ar71xx-nand &&\
make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/beta' GLUON_BRANCH=beta GLUON_TARGET=mpc85xx-generic &&\
make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/beta' GLUON_BRANCH=beta GLUON_TARGET=x86-generic &&\
make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/beta' GLUON_BRANCH=beta GLUON_TARGET=x86-kvm_guest &&\
make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/beta' GLUON_BRANCH=beta GLUON_TARGET=x86-64 &&\
make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/beta' GLUON_BRANCH=beta GLUON_TARGET=x86-xen_domu &&\
make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/beta' GLUON_BRANCH=beta GLUON_TARGET=ramips-rt305x &&\
make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/beta' GLUON_BRANCH=beta GLUON_TARGET=brcm2708-bcm2708 &&\
make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/beta' GLUON_BRANCH=beta GLUON_TARGET=brcm2708-bcm2709 &&\
make manifest -j17 BROKEN=1 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/beta' GLUON_BRANCH=beta GLUON_TARGET=sunxi &&\
make images -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/stable' GLUON_BRANCH=stable GLUON_TARGET=ar71xx-generic &&\
make images -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/stable' GLUON_BRANCH=stable GLUON_TARGET=ar71xx-nand &&\
make images -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/stable' GLUON_BRANCH=stable GLUON_TARGET=mpc85xx-generic &&\
make images -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/stable' GLUON_BRANCH=stable GLUON_TARGET=x86-generic &&\
make images -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/stable' GLUON_BRANCH=stable GLUON_TARGET=x86-kvm_guest &&\
make images -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/stable' GLUON_BRANCH=stable GLUON_TARGET=x86-64 &&\
make images -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/stable' GLUON_BRANCH=stable GLUON_TARGET=x86-xen_domu &&\
make images -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/stable' GLUON_BRANCH=stable GLUON_TARGET=ramips-rt305x &&\
make images -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/stable' GLUON_BRANCH=stable GLUON_TARGET=brcm2708-bcm2708 &&\
make images -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/stable' GLUON_BRANCH=stable GLUON_TARGET=brcm2708-bcm2709 &&\
make images -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/stable' GLUON_BRANCH=stable GLUON_TARGET=sunxi &&\
make manifest -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/stable' GLUON_BRANCH=stable GLUON_TARGET=ar71xx-generic &&\
make manifest -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/stable' GLUON_BRANCH=stable GLUON_TARGET=ar71xx-nand &&\
make manifest -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/stable' GLUON_BRANCH=stable GLUON_TARGET=mpc85xx-generic &&\
make manifest -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/stable' GLUON_BRANCH=stable GLUON_TARGET=x86-generic &&\
make manifest -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/stable' GLUON_BRANCH=stable GLUON_TARGET=x86-kvm_guest &&\
make manifest -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/stable' GLUON_BRANCH=stable GLUON_TARGET=x86-64 &&\
make manifest -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/stable' GLUON_BRANCH=stable GLUON_TARGET=x86-xen_domu &&\
make manifest -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/stable' GLUON_BRANCH=stable GLUON_TARGET=ramips-rt305x &&\
make manifest -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/stable' GLUON_BRANCH=stable GLUON_TARGET=brcm2708-bcm2708 &&\
make manifest -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/stable' GLUON_BRANCH=stable GLUON_TARGET=brcm2708-bcm2709 &&\
make manifest -j17 BROKEN=0 GLUON_IMAGEDIR='$(GLUON_OUTPUTDIR)/stable' GLUON_BRANCH=stable GLUON_TARGET=sunxi &&\
