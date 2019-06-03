* **********************************************
* *             TSMC SPICE MODEL               *
* **********************************************
*  
*    PROCESS :  0.25um Mixed-Signal SALICIDE(2P5M or 1P5M+, 2.5V/3.3V)
*     MODEL  :  BSIM3 ( Mixed V3.1 & V3.2 )
*    DOC. NO.:  T-025-MM-SP-001
*    VERSION :  1.5
*    DATE    :  Sept. 20, 2000
*    HSPICE VERSION : For H98.2 & H98.4 only
*
******************************************************************************
*                                                                            *
*       IN THIS MODEL LIB CONTAINS :                                         *
*                                                                            *
*       1.LIB TT                                                             *
*             SS                                                             *
*             FF                                                             *
*             SF                                                             *
*             FS                                                             *
*       (2.5V Nominal Vt devices with different geometric and corner models) *
*                                                                            *
*       2.LIB TT_3V                                                          *
*             SS_3V                                                          *
*             FF_3V                                                          *
*             SF_3V                                                          *
*             FS_3V                                                          *
*       (3.3V Nominal Vt devices with different geometric and corner models) *
*                                                                            *
*       3.LIB TT_3VS                                                         *
*             SS_3VS                                                         *
*             FF_3VS                                                         *
*             SF_3VS                                                         *
*             FS_3VS                                                         *
*       (3.3V Symmetry Vt devices with different geometric and corner models)*
*                                                                            *
*       4.LIB TT_ESD                                                         *
*             SS_ESD                                                         *
*             FF_ESD                                                         *
*             SF_ESD                                                         *
*             FS_ESD                                                         *
*       (3.3V ESD devices with different geometric and corner models)        *
*                                                                            *
*       5.LIB TT_M2                                                          *
*             SS_M2                                                          *
*             FF_M2                                                          *
*             SF_M2                                                          *
*             FS_M2                                                          *
*       (2.5V Medium Vt devices with different geometric and corner models)  *
*                                                                            *
*       6.LIB TT_L2                                                          *
*             SS_L2                                                          *
*             FF_L2                                                          *
*             SF_L2                                                          *
*             FS_L2                                                          *
*       (2.5V Native Vt devices with different geometric and corner models)     *
*                                                                            *
*       7.LIB TT_Z2                                                          *
*             SS_Z2                                                          *
*             FF_Z2                                                          *
*             SF_Z2                                                          *
*             FS_Z2                                                          *
*       (2.5V Zero Vt devices with different geometric and corner models)    *
*                                                                            *
*       8.LIB TT_N3                                                          *
*             SS_N3                                                          *
*             FF_N3                                                          *
*             SF_N3                                                          *
*             FS_N3                                                          *
*       (3.3V Native Vt devices with different geometric and corner models)  *
*                                                                            *
*       9.LIB BIP                                                            *
*        ( P+/NW/PSUB 10x10, 5x5 and 2x2 vertical PNP bipolar )              *
*                                                                            *
*      10.LIB DIO                                                            *
*        ( P+/NW , N+/PW & NW/PSUB diode )                                   *
*                                                                            *
*      11.LIB RES                                                            *
*                                                                            *
******************************************************************************
*
* 1)To use these models directly by programming in this style: 
*
*     .lib 'lib_path/lib_name' corner_name 
*
*  EX: .lib '/home/user/tsmc/MIXED025/mix025_1.l' TT   
*        
*             for typical 2.5V Nominal Vt Devices
*      
*      .lib '/home/user/tsmc/MIXED025/mix025_1.l' TT_3V   
*        
*             for typical 3.3V Nominal Vt Devices
*      
* note:
* corner_name
* TT : typical model for 2.5V Nominal Vt devices
* SS : Slow NMOS Slow PMOS model for 2.5V Nominal Vt devices
* FF : Fast NMOS Fast PMOS model for 2.5V Nominal Vt devices
* SF : Slow NMOS Fast PMOS model for 2.5V Nominal Vt devices
* FS : Fast NMOS Slow PMOS model for 2.5V Nominal Vt devices
*      
* TT_3V : typical model for 3.3V Nominal Vt devices
* SS_3V : Slow NMOS Slow PMOS model for 3.3V Nominal Vt devices
* FF_3V : Fast NMOS Fast PMOS model for 3.3V Nominal Vt devices
* SF_3V : Slow NMOS Fast PMOS model for 3.3V Nominal Vt devices
* FS_3V : Fast NMOS Slow PMOS model for 3.3V Nominal Vt devices
*
* TT_3VS : typical PMOS model for 3.3V Symmetry Vt devices
* SS_3VS : Slow PMOS model for 3.3V Symmetry Vt devices
* FF_3VS : Fast PMOS model for 3.3V Symmetry Vt devices
* SF_3VS : Fast PMOS model for 3.3V Symmetry Vt devices
* FS_3VS : Slow PMOS model for 3.3V Symmetry Vt devices
*
* TT_ESD : typical NMOS model for 3.3V ESD devices
* SS_ESD : Slow NMOS model for 3.3V ESD devices
* FF_ESD : Fast NMOS model for 3.3V ESD devices
* SF_ESD : Slow NMOS model for 3.3V ESD devices
* FS_ESD : Fast NMOS model for 3.3V ESD devices
*
* TT_M2 : typical model for 2.5V Medium Vt devices
* SS_M2 : Slow NMOS Slow PMOS model for 2.5V Medium Vt devices
* FF_M2 : Fast NMOS Fast PMOS model for 2.5V Medium Vt devices
* SF_M2 : Slow NMOS Fast PMOS model for 2.5V Medium Vt devices
* FS_M2 : Fast NMOS Slow PMOS model for 2.5V Medium Vt devices
*      
* TT_L2 : typical model for 2.5V Native Vt devices
* SS_L2 : Slow NMOS model for 2.5V Native Vt devices
* FF_L2 : Fast NMOS model for 2.5V Native Vt devices
* SF_L2 : Slow NMOS model for 2.5V Native Vt devices
* FS_L2 : Fast NMOS model for 2.5V Native Vt devices
*      
* TT_Z2 : typical model for 2.5V Zero Vt devices
* SS_Z2 : Slow NMOS Slow PMOS model for 2.5V Zero Vt devices
* FF_Z2 : Fast NMOS Fast PMOS model for 2.5V Zero Vt devices
* SF_Z2 : Slow NMOS Fast PMOS model for 2.5V Zero Vt devices
* FS_Z2 : Fast NMOS Slow PMOS model for 2.5V Zero Vt devices
*      
* TT_N3 : typical NMOS model for 3.3V Native Vt devices
* SS_N3 : Slow NMOS model for 3.3V Native Vt devices
* FF_N3 : Fast NMOS model for 3.3V Native Vt devices
* SF_N3 : Slow NMOS model for 3.3V Native Vt devices
* FS_N3 : Fast NMOS model for 3.3V Native Vt devices
*      
* 2)HDIF depends on your layout poly spacer to contact center distance.
*   The value listed here is TSMC minimum-rule value. you can change it
*   according to your layout.
*
*
***************************************************************
*                                                             *
*              2.5V NOMINAL Vt DEVICES LIB                    *
*                                                             *
***************************************************************
***************** CORNER_LIB OF TYPICAL MODEL ******************
.LIB TT
.param toxp = 5.4e-9 toxn = 5.4e-9 
+dxl = 0 dxw = 0 
+dvthn = 0.0 dvthp = 0.00 
+cjn = 1.836615E-03    cjp= 1.833935E-03           
+cjswn = 4.234822E-10  cjswp = 3.472876E-10       
+cgon    = 1.3E-10    cgop = 1.6E-10
+cgln = 2.1E-10    cglp = 2.1E-10  
+cjgaten = 3.286035E-10 cjgatep = 2.500235E-10     
+hdifn = 2.625e-07 hdifp = 2.625e-7 
.lib 'mix025_1.l' MOS
.ENDL TT
**************** CORNER_LIB OF  SNSP   MODEL *******************
.LIB SS
.param toxp = 5.7e-9 toxn = 5.7e-9 
+dxl = 2.0e-8 dxw = -3e-8  
+dvthn = 0.06 dvthp = -0.05
+cjn = 1.92844575E-3 cjp= 1.92563175e-3  
+cjswn = 4.4465631E-10 cjswp = 3.6465198e-10 
+cgon    = 1.235E-10 cgop = 1.52e-10
+cgln = 1.995E-10    cglp = 1.995E-10 
+cjgaten = 3.45033675E-10 cjgatep = 2.62524675e-10
+hdifn = 2.625e-07 hdifp = 2.625e-7
.lib 'mix025_1.l' MOS
.ENDL SS
**************** CORNER_LIB OF  FNFP   MODEL *******************
.LIB FF
.param toxp = 5.1e-9 toxn = 5.1e-9 
+dxl = -2.0e-8 dxw = 3e-8  
+dvthn = -0.06 dvthp = 0.05 
+cjn = 1.74478425e-3 cjp= 1.74223825e-3  
+cjswn = 4.0230809e-10 cjswp = 3.2992322e-10 
+cgon    = 1.365e-10 cgop = 1.68e-10
+cgln = 2.205E-10    cglp = 2.205E-10 
+cjgaten = 3.12173325e-10 cjgatep = 2.37522325e-10
+hdifn = 2.625e-07 hdifp = 2.625e-7 
.lib 'mix025_1.l' MOS
.ENDL FF
**************** CORNER_LIB OF  SNFP   MODEL *******************
.LIB SF
.param toxp = 5.4e-9 toxn = 5.4e-9 
+dxl = 0 dxw = 0 
+dvthn = 0.06 dvthp = 0.05
+cjn = 1.92844575E-3 cjp= 1.74223825e-3  
+cjswn = 4.4465631E-10 cjswp = 3.2992322e-10 
+cgon    =  1.235E-10 cgop = 1.68e-10
+cgln = 1.995E-10    cglp = 2.205E-10
+cjgaten = 3.45033675E-10 cjgatep = 2.37522325e-10
+hdifn = 2.625e-07 hdifp = 2.625e-7
.lib 'mix025_1.l' MOS
.ENDL SF
**************** CORNER_LIB OF  FNSP   MODEL *******************
.LIB FS
.param toxp = 5.4e-9 toxn = 5.4e-9 
+dxl = 0 dxw = 0 
+dvthn = -0.06 dvthp = -0.05
+cjn = 1.74478425e-3 cjp= 1.92563175e-3  
+cjswn = 4.0230809e-10 cjswp = 3.6465198e-10 
+cgon    =  1.365E-10 cgop = 1.52e-10
+cgln = 2.205E-10    cglp = 1.995E-10 
+cjgaten = 3.12173325e-10 cjgatep = 2.62524675e-10
+hdifn = 2.625e-07 hdifp = 2.625e-7
.lib 'mix025_1.l' MOS
.ENDL FS
**************************************************************************
***************************************************************
*                                                             *
*                3.3V NOMINAL VT DEVICES LIB                  *
*                                                             *
***************************************************************
***************** CORNER_LIB OF TYPICAL MODEL ****************************
.LIB TT_3V
.param toxn3= 7.1e-09 toxp3= 7.1e-09 
+dxl3 = 0 dxw3= 0
+dvthn3 = 0 dvthp3 = 0 
+cjn3= 1.174961e-03 cjp3= 1.838441e-03 
+cjswn3= 2.60199e-10 cjswp3= 3.67677e-10 
+cjgaten3= 1.63849e-10 cjgatep3= 2.64702e-10 
+cgon3 = 2.416e-10 cgop3 = 2.21e-10 
+hdifn3= 2.625e-07 hdifp3= 2.625e-07 
.lib 'mix025_1.l' MOS_3V
.ENDL TT_3V
***************** CORNER_LIB OF SNSP MODEL ****************************
.LIB SS_3V
.param toxn3= 7.8e-09 toxp3= 7.8e-09 
+dxl3 = 2.0e-08 dxw3= -3e-08
+dvthn3 = 0.1 dvthp3 = -0.1 
+cjn3= 1.233709e-03 cjp3= 1.930363e-03 
+cjswn3= 2.73209e-10 cjswp3= 3.86061e-10 
+cjgaten3= 1.72041e-10 cjgatep3= 2.77937e-10 
+cgon3 = 2.2952e-10 cgop3 = 2.0995e-10 
+hdifn3= 2.625e-07 hdifp3= 2.625e-07 
.lib 'mix025_1.l' MOS_3V
.ENDL SS_3V
***************** CORNER_LIB OF FNFP MODEL ****************************
.LIB FF_3V
.param toxn3= 6.4e-09 toxp3= 6.4e-09 
+dxl3 = -2.0e-08 dxw3= 3e-08
+dvthn3 = -0.1 dvthp3 = 0.1 
+cjn3= 1.116213e-03 cjp3= 1.746519e-03 
+cjswn3= 2.47189e-10 cjswp3= 3.49293e-10 
+cjgaten3= 1.55657e-10 cjgatep3= 2.51467e-10 
+cgon3 = 2.5368e-10 cgop3 = 2.3205e-10 
+hdifn3= 2.625e-07 hdifp3= 2.625e-07 
.lib 'mix025_1.l' MOS_3V
.ENDL FF_3V
***************** CORNER_LIB OF SNFP MODEL ****************************
.LIB SF_3V
.param toxn3= 7.1e-09 toxp3= 7.1e-09 
+dxl3 = 0 dxw3= 0
+dvthn3 = 0.1 dvthp3 = 0.1 
+cjn3= 1.233709e-03 cjp3= 1.746519e-03 
+cjswn3= 2.73209e-10 cjswp3= 3.49293e-10 
+cjgaten3= 1.72041e-10 cjgatep3= 2.51467e-10 
+cgon3 = 2.416e-10 cgop3 = 2.21e-10 
+hdifn3= 2.625e-07 hdifp3= 2.625e-07 
.lib 'mix025_1.l' MOS_3V
.ENDL SF_3V
***************** CORNER_LIB OF FNSP MODEL ****************************
.LIB FS_3V
.param toxn3= 7.1e-09 toxp3= 7.1e-09 
+dxl3 = 0 dxw3= 0
+dvthn3 = -0.1 dvthp3 = -0.1 
+cjn3= 1.116213e-03 cjp3= 1.930363e-03 
+cjswn3= 2.47189e-10 cjswp3= 3.86061e-10 
+cjgaten3= 1.55657e-10 cjgatep3= 2.77937e-10 
+cgon3 = 2.416e-10 cgop3 = 2.21e-10 
+hdifn3= 2.625e-07 hdifp3= 2.625e-07 
.lib 'mix025_1.l' MOS_3V
.ENDL FS_3V
**************************************************************************
***************************************************************
*                                                             *
*                3.3V SYMMETRY VT DEVICES LIB                 *
*                                                             *
***************************************************************
***************** CORNER_LIB OF TYPICAL MODEL ****************************
.LIB TT_3VS
.param toxp3s= 7.1e-09
+dxl3s= 0 dxw3s= 0
+dvthp3s= 0
+cjp3s= 1.590908E-03
+cjswp3s= 3.120446E-10 
+cjgatep3s= 2.246509E-10
+cgop3s= 3.22e-10
+hdifp3s= 2.625e-07
.lib 'mix025_1.l' MOS_3VS
.ENDL TT_3VS
***************** CORNER_LIB OF SNSP MODEL ****************************
.LIB SS_3VS
.param toxp3s= 7.8e-09 
+dxl3s= 2.0e-08 dxw3s= -3e-08
+dvthp3s= -0.1
+cjp3s= 1.6704534E-03 
+cjswp3s= 3.2764683E-10 
+cjgatep3s= 2.35883445E-10
+cgop3s= 3.059e-10
+hdifp3s= 2.625e-07
.lib 'mix025_1.l' MOS_3VS
.ENDL SS_3VS
***************** CORNER_LIB OF FNFP MODEL ****************************
.LIB FF_3VS
.param toxp3s= 6.4e-09
+dxl3s= -2.0e-08 dxw3s= 3e-08
+dvthp3s= 0.1
+cjp3s= 1.5113626E-03
+cjswp3s= 2.9644237E-10 
+cjgatep3s= 2.13418355E-10
+cgop3s= 3.381e-10
+hdifp3s= 2.625e-07
.lib 'mix025_1.l' MOS_3VS
.ENDL FF_3VS
***************** CORNER_LIB OF SNFP MODEL ****************************
.LIB SF_3VS
.param toxp3s= 7.1e-09 
+dxl3s= 0 dxw3s= 0
+dvthp3s= 0.1
+cjp3s= 1.5113626E-03
+cjswp3s= 2.9644237E-10
+cjgatep3s= 2.13418355E-10
+cgop3s= 3.22e-10
+hdifp3s= 2.625e-07
.lib 'mix025_1.l' MOS_3VS
.ENDL SF_3VS
***************** CORNER_LIB OF FNSP MODEL ****************************
.LIB FS_3VS
.param toxp3s= 7.1e-09
+dxl3s= 0 dxw3s= 0
+dvthp3s= -0.1
+cjp3s= 1.6704534E-03
+cjswp3s= 3.2764683E-10
+cjgatep3s= 2.35883445E-10
+cgop3s= 3.22e-10
+hdifp3s= 2.625e-07
.lib 'mix025_1.l' MOS_3VS
.ENDL FS_3VS
**************************************************************************
**************************************************************************
***************************************************************
*                                                             *
*                3.3V ESD DEVICES LIB                         *
*                                                             *
***************************************************************
***************** CORNER_LIB OF TYPICAL MODEL ****************************
.LIB TT_ESD
.param toxe3 = 7.1e-9
+dxle3 = 0 dxwe3= 0
+dvthe3 = 0.0
+cje3 = 1.138888e-03
+cjswe3 = 3.263546e-10
+cjgatee3 = 1.944610e-10
+cgoe3= 2.942000e-10
+hdife3 = 1.68e-06
.lib 'mix025_1.l' ESD
.ENDL TT_ESD
***************** CORNER_LIB OF SNSP MODEL ****************************
.LIB SS_ESD
.param toxe3 = 7.8e-9
+dxle3 = 2.0e-08 dxwe3= -3e-08
+dvthe3 = 0.1
+cje3 = 1.1958e-03
+cjswe3 = 3.427e-10
+cjgatee3 = 2.042e-10
+cgoe3= 2.795e-10
+hdife3 = 1.68e-06
.lib 'mix025_1.l' ESD
.ENDL SS_ESD
***************** CORNER_LIB OF FNFP MODEL ****************************
.LIB FF_ESD
.param toxe3 = 6.4e-9
+dxle3 = -2.0e-08 dxwe3= 3e-08
+dvthe3 = -0.1
+cje3 = 1.0819e-03
+cjswe3 = 3.100e-10
+cjgatee3 = 1.847e-10
+cgoe3= 3.089e-10
+hdife3 = 1.68e-06
.lib 'mix025_1.l' ESD
.ENDL FF_ESD
***************** CORNER_LIB OF SNFP MODEL ****************************
.LIB SF_ESD
.param toxe3 = 7.1e-9
+dxle3 = 0 dxwe3= 0
+dvthe3 = 0.1
+cje3 = 1.1958e-03
+cjswe3 = 3.427e-10
+cjgatee3 = 2.042e-10
+cgoe3= 2.942000e-10
+hdife3 = 1.68e-06
.lib 'mix025_1.l' ESD
.ENDL SF_ESD
***************** CORNER_LIB OF FNSP MODEL ****************************
.LIB FS_ESD
.param toxe3 = 7.1e-9
+dxle3 = 0 dxwe3= 0
+dvthe3 = -0.1
+cje3 = 1.0819e-03
+cjswe3 = 3.100e-10
+cjgatee3 = 1.847e-10
+cgoe3= 2.942000e-10
+hdife3 = 1.68e-06
.lib 'mix025_1.l' ESD
.ENDL FS_ESD
**************************************************************************
***************************************************************
*                                                             *
*                2.5V MEDIUM VT DEVICES LIB                   *
*                                                             *
***************************************************************
***************** CORNER_LIB OF TYPICAL MODEL ****************************
.LIB TT_M2
.param toxnm= 5.4e-09 toxpm= 5.4e-09
+dxlm= 0 dxwm= 0
+dvthnm= 0 dvthpm= 0
+cjnm= 1.468485e-03 cjpm= 1.497972e-03
+cjswnm= 3.56171e-10 cjswpm= 2.7721e-10
+cjgatenm= 2.229e-10 cjgatepm= 1.996e-10
+cgonm= 3.782e-10 cgopm= 3.515e-10
+hdifnm= 2.625e-07 hdifpm= 2.625e-07
.lib 'mix025_1.l' MOSM2
.ENDL TT_M2
***************** CORNER_LIB OF SNSP MODEL ****************************
.LIB SS_M2
.param toxnm= 5.7e-09 toxpm= 5.7e-09
+dxlm= 2.0e-08 dxwm= -3e-08
+dvthnm= 0.1 dvthpm= -0.1
+cjnm= 1.541909e-03 cjpm= 1.572871e-03
+cjswnm= 3.7398e-10 cjswpm= 2.9107e-10
+cjgatenm= 2.34045e-10 cjgatepm= 2.0958e-10
+cgonm= 3.5929e-10 cgopm= 3.33925e-10
+hdifnm= 2.625e-07 hdifpm= 2.625e-07
.lib 'mix025_1.l' MOSM2
.ENDL SS_M2
***************** CORNER_LIB OF FNFP MODEL ****************************
.LIB FF_M2
.param toxnm= 5.1e-09 toxpm= 5.1e-09
+dxlm= -2.0e-08 dxwm= 3e-08
+dvthnm= -0.1 dvthpm= 0.1
+cjnm= 1.395061e-03 cjpm= 1.423073e-03
+cjswnm= 3.38363e-10 cjswpm= 2.63349e-10
+cjgatenm= 2.11755e-10 cjgatepm= 1.8962e-10
+cgonm= 3.9711e-10 cgopm= 3.69075e-10
+hdifnm= 2.625e-07 hdifpm= 2.625e-07
.lib 'mix025_1.l' MOSM2
.ENDL FF_M2
***************** CORNER_LIB OF SNFP MODEL ****************************
.LIB SF_M2
.param toxnm= 5.4e-09 toxpm= 5.4e-09
+dxlm= 0 dxwm= 0
+dvthnm= 0.1 dvthpm= 0.1
+cjnm= 1.541909e-03 cjpm= 1.423073e-03
+cjswnm= 3.7398e-10 cjswpm= 2.63349e-10
+cjgatenm= 2.34045e-10 cjgatepm= 1.8962e-10
+cgonm= 3.782e-10 cgopm= 3.515e-10
+hdifnm= 2.625e-07 hdifpm= 2.625e-07
.lib 'mix025_1.l' MOSM2
.ENDL SF_M2
***************** CORNER_LIB OF FNSP MODEL ****************************
.LIB FS_M2
.param toxnm= 5.4e-09 toxpm= 5.4e-09
+dxlm= 0 dxwm= 0
+dvthnm= -0.1 dvthpm= -0.1
+cjnm= 1.395061e-03 cjpm= 1.572871e-03
+cjswnm= 3.38363e-10 cjswpm= 2.9107e-10
+cjgatenm= 2.11755e-10 cjgatepm= 2.0958e-10
+cgonm= 3.782e-10 cgopm= 3.515e-10
+hdifnm= 2.625e-07 hdifpm= 2.625e-07
.lib 'mix025_1.l' MOSM2
.ENDL FS_M2
**************************************************************************
***************************************************************
*                                                             *
*                2.5V NATIVE VT DEVICES LIB                      *
*                                                             *
***************************************************************
***************** CORNER_LIB OF TYPICAL MODEL ****************************
.LIB TT_L2
.param toxnl= 5.4e-09  
+dxll= 0 dxwl= 0
+dvthnl= 0  
+cjnl= 1.225575e-03  
+cjswnl= 3.7325e-10  
+cjgatenl= 2.89625e-10 
+cgonl= 3.802e-10  
+hdifnl= 2.625e-07  
.lib 'mix025_1.l' MOSL2
.ENDL TT_L2
***************** CORNER_LIB OF SNSP MODEL ****************************
.LIB SS_L2
.param toxnl= 5.7e-09  
+dxll= 2.0e-08 dxwl= -3e-08
+dvthnl= 0.12  
+cjnl= 1.286854e-03  
+cjswnl= 3.91912e-10  
+cjgatenl= 3.04107e-10  
+cgonl= 3.6119e-10  
+hdifnl= 2.625e-07  
.lib 'mix025_1.l' MOSL2
.ENDL SS_L2
***************** CORNER_LIB OF FNFP MODEL ****************************
.LIB FF_L2
.param toxnl= 5.1e-09  
+dxll= -2.0e-08 dxwl= 3e-08
+dvthnl= -0.12  
+cjnl= 1.164296e-03  
+cjswnl= 3.54587e-10  
+cjgatenl= 2.75144e-10  
+cgonl= 3.9921e-10  
+hdifnl= 2.625e-07  
.lib 'mix025_1.l' MOSL2
.ENDL FF_L2
***************** CORNER_LIB OF SNFP MODEL ****************************
.LIB SF_L2
.param toxnl= 5.4e-09  
+dxll= 0 dxwl= 0
+dvthnl= 0.12  
+cjnl= 1.286854e-03  
+cjswnl= 3.91912e-10  
+cjgatenl= 3.04107e-10  
+cgonl= 3.802e-10  
+hdifnl= 2.625e-07  
.lib 'mix025_1.l' MOSL2
.ENDL SF_L2
***************** CORNER_LIB OF FNSP MODEL ****************************
.LIB FS_L2
.param toxnl= 5.4e-09  
+dxll= 0 dxwl= 0
+dvthnl= -0.12  
+cjnl= 1.164296e-03  
+cjswnl= 3.54587e-10  
+cjgatenl= 2.75144e-10  
+cgonl= 3.802e-10  
+hdifnl= 2.625e-07  
.lib 'mix025_1.l' MOSL2
.ENDL FS_L2
**************************************************************************
***************************************************************
*                                                             *
*                2.5V ZERO VT DEVICES LIB                     *
*                                                             *
***************************************************************
***************** CORNER_LIB OF TYPICAL MODEL ****************************
.LIB TT_Z2
.param toxnz= 5.4e-09 toxpz= 5.4e-09
+dxlz= 0 dxwz= 0
+dvthnz= 0 dvthpz= 0
+cjnz= 1.517315e-03 cjpz= 1.402276e-03
+cjswnz= 3.79183e-10 cjswpz= 2.99333e-10
+cjgatenz= 2.373e-10 cjgatepz= 2.155e-10
+cgonz= 5.357e-10 cgopz= 3.802e-10
+hdifnz= 2.625e-07 hdifpz= 2.625e-07
.lib 'mix025_1.l' MOSZ2
.ENDL TT_Z2
***************** CORNER_LIB OF SNSP MODEL ****************************
.LIB SS_Z2
.param toxnz= 5.7e-09 toxpz= 5.7e-09
+dxlz= 2.0e-08 dxwz= -3e-08
+dvthnz= 0.12 dvthpz= -0.12
+cjnz= 1.593181e-03 cjpz= 1.472390e-03
+cjswnz= 3.98142e-10 cjswpz= 3.14299e-10
+cjgatenz= 2.49165e-10 cjgatepz= 2.26275e-10
+cgonz= 5.08915e-10 cgopz= 3.6119e-10
+hdifnz= 2.625e-07 hdifpz= 2.625e-07
.lib 'mix025_1.l' MOSZ2
.ENDL SS_Z2
***************** CORNER_LIB OF FNFP MODEL ****************************
.LIB FF_Z2
.param toxnz= 5.1e-09 toxpz= 5.1e-09
+dxlz= -2.0e-08 dxwz= 3e-08
+dvthnz= -0.12 dvthpz= 0.12
+cjnz= 1.441449e-03 cjpz= 1.332162e-03
+cjswnz= 3.60224e-10 cjswpz= 2.84366e-10
+cjgatenz= 2.25435e-10 cjgatepz= 2.04725e-10
+cgonz= 5.62485e-10 cgopz= 3.9921e-10
+hdifnz= 2.625e-07 hdifpz= 2.625e-07
.lib 'mix025_1.l' MOSZ2
.ENDL FF_Z2
***************** CORNER_LIB OF SNFP MODEL ****************************
.LIB SF_Z2
.param toxnz= 5.4e-09 toxpz= 5.4e-09
+dxlz= 0 dxwz= 0
+dvthnz= 0.12 dvthpz= 0.12
+cjnz= 1.593181e-03 cjpz= 1.332162e-03
+cjswnz= 3.98142e-10 cjswpz= 2.84366e-10
+cjgatenz= 2.49165e-10 cjgatepz= 2.04725e-10
+cgonz= 5.357e-10 cgopz= 3.802e-10
+hdifnz= 2.625e-07 hdifpz= 2.625e-07
.lib 'mix025_1.l' MOSZ2
.ENDL SF_Z2
***************** CORNER_LIB OF FNSP MODEL ****************************
.LIB FS_Z2
.param toxnz= 5.4e-09 toxpz= 5.4e-09
+dxlz= 0 dxwz= 0
+dvthnz= -0.12 dvthpz= -0.12
+cjnz= 1.441449e-03 cjpz= 1.472390e-03
+cjswnz= 3.60224e-10 cjswpz= 3.14299e-10
+cjgatenz= 2.25435e-10 cjgatepz= 2.26275e-10
+cgonz= 5.357e-10 cgopz= 3.802e-10
+hdifnz= 2.625e-07 hdifpz= 2.625e-07
.lib 'mix025_1.l' MOSZ2
.ENDL FS_Z2
**************************************************************************
***************************************************************
*                                                             *
*                3.3V NATIVE VT DEVICES LIB                   *
*                                                             *
***************************************************************
************** CORNER_LIB OF TYPICAL MODEL ****************************
.LIB TT_N3
.param toxz3 = 7.1e-09 dxlz3 = 0 dxwz3 = 0
+dvthz3 = 0 
+cjz3 = 1.217093e-4  
+cjswz3 = 1.206517e-10  
+cjgatez3 = 9.287151e-11  
+cgoz3 = 3.96e-10  
+hdifz3 = 2.625e-7  
.lib 'mix025_1.l' MOSN3
.ENDL TT_N3
**************** CORNER_LIB OF  SNSP   MODEL ****************************
.LIB SS_N3
.param toxz3 = 7.8e-09 dxlz3 = 2.0e-8 dxwz3 = -3e-8
+dvthz3 = 0.12 
+cjz3 = 1.27794765E-4 
+cjswz3 = 1.26684285e-10 
+cjgatez3 = 9.75150855e-11 
+cgoz3 = 3.762e-10 
+hdifz3 = 2.625e-7 
.lib 'mix025_1.l' MOSN3
.ENDL SS_N3
**************** CORNER_LIB OF  FNFP   MODEL ****************************
.LIB FF_N3
.param toxz3 = 6.4e-09 dxlz3 = -2.0e-8 dxwz3 = 3e-8
+dvthz3 = -0.12 
+cjz3 = 1.15623835E-4 
+cjswz3 = 1.14619115e-10 
+cjgatez3 = 8.82279345e-11 
+cgoz3 = 4.158e-10 
+hdifz3 = 2.625e-7 
.lib 'mix025_1.l' MOSN3
.ENDL FF_N3
**************** CORNER_LIB OF  SNFP   MODEL ****************************
.LIB SF_N3
.param toxz3 = 7.1e-09  dxlz3 = 0 dxwz3 = 0
+dvthz3 = 0.12 
+cjz3 = 1.27794765E-4 
+cjswz3 = 1.26684285e-10 
+cjgatez3 = 9.75150855e-11 
+cgoz3 = 3.96e-10 
+hdifz3 = 2.625e-7 
.lib 'mix025_1.l' MOSN3
.ENDL SF_N3
**************** CORNER_LIB OF  FNSP   MODEL ****************************
.LIB FS_N3
.param toxz3 = 7.1e-09  dxlz3 = 0 dxwz3 = 0
+dvthz3 = -0.12
+cjz3 = 1.15623835E-4 
+cjswz3 = 1.14619115e-10 
+cjgatez3 = 8.82279345e-11 
+cgoz3 = 3.96e-10 
+hdifz3 = 2.625e-7 
.lib 'mix025_1.l' MOSN3
.ENDL FS_N3
***************************************************************************
*
.LIB MOS
***************************************************************
*                                                             *
*               NORMAL DEVICES MODEL                          *
*                                                             *
***************************************************************
***************************************************************
*                 NMOS DEVICES MODEL                          *
***************************************************************
.MODEL nch.1            NMOS   (                    LMIN     = '1.2E-06-dxl'  
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = 2.1E-05        WMIN     = '1.2E-06-dxw'  WMAX     = 1.01E-04       
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl'    
+NLEV    = 3              AF       = 0.8824         KF       = 3.454E-24      
+XW      = '0+dxw'        VERSION  = 3.2            TOX      = toxn           
+XJ      = 1E-07          NCH      = 1.63E+17       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 2E-08          WINT     = 2E-08          MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '0.4767749+dvthn' LVTH0 = 3.507137E-08   WVTH0    = -1.453229E-08  
+PVTH0   = -6.620086E-15  K1       = 0.4472964      LK1      = -5.39693E-08   
+WK1     = -4.269873E-08  PK1      = 5.981896E-14   K2       = 0.004538423    
+LK2     = 2.041006E-08   WK2      = 1.682965E-08   PK2      = -2.784819E-14  
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 120633         LVSAT    = -0.01265326    
+UA      = -9.218065E-10  LUA      = -1.161761E-16  WUA      = 1.451009E-16   
+PUA     = -5.566174E-23  UB       = 1.81497E-18    LUB      = 1.561614E-25   
+WUB     = -2.338524E-25  PUB      = 8.58042E-33    UC       = 4.365745E-11   
+LUC     = 8.007525E-18   WUC      = -7.436576E-18  PUC      = -6.149303E-24  
+RDSW    = 187            PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.03077917     LU0      = 5.598957E-11   
+WU0     = -8.158919E-11  PU0      = 1.090017E-15   A0       = 0.5252816      
+LA0     = 4.042826E-08   WA0      = 1.225374E-07   PA0      = -2.063631E-13  
+KETA    = 0.003461425    LKETA    = -9.223886E-09  WKETA    = -8.366612E-11  
+PKETA   = 1.672486E-15   A1       = 0              A2       = 0.65           
+AGS     = 0.01           B0       = 0              B1       = 0              
+VOFF    = -0.1517445     LVOFF    = 2.086556E-08   WVOFF    = 6.482217E-09   
+PVOFF   = -7.791971E-15  NFACTOR  = 1              CIT      = 0.000377699    
+LCIT    = 7.405382E-10   WCIT     = -6.34899E-10   PCIT     = 7.555298E-16   
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = 3.836953E-05   LETA0    = 2.324929E-10   WETA0    = 8.055062E-12   
+PETA0   = -1.610206E-16  ETAB     = -4.68351E-05   LETAB    = -6.326623E-11  
+DSUB    = 0              PCLM     = 0.4755805      LPCLM    = 4.88145E-07    
+WPCLM   = -6.231367E-09  PPCLM    = 1.245653E-13   PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0002151594   LPDIBLC2 = 5.69396E-09    PDIBLCB  = 0.01           
+DROUT   = 0              PSCBE1   = 1.213673E+08   LPSCBE1  = 265.5531       
+WPSCBE1 = -3.167115      PPSCBE1  = -1.324478E-05  PSCBE2   = 1E-06          
+PVAG    = 0              DELTA    = 0.01           ALPHA0   = 4.200379E-06   
+BETA0   = 20.54463       KT1      = -0.2402984     LKT1     = -1.511487E-08  
+WKT1    = 1.116811E-08   PKT1     = -1.329005E-14  KT2      = -0.02232689    
+LKT2    = -1.527194E-08  WKT2     = -1.12105E-08   PKT2     = 1.287179E-14   
+AT      = 35000          UTE      = -1.688541      LUTE     = 3.778586E-09   
+WUTE    = 1.029916E-07   PUTE     = -5.895606E-14  UA1      = 9.999999E-11   
+UB1     = 0              UC1      = -4.534566E-11  LUC1     = 7.638851E-17   
+WUC1    = 8.059368E-17   PUC1     = -8.934457E-23  KT1L     = 0              
+PRT     = 0              CJ       = cjn            MJ       = 0.4708251      
+PB      = 0.9597901      CJSW     = cjswn          MJSW     = 0.379613       
+PBSW    = 0.9597901      CJSWG    = cjgaten        MJSWG    = 0.379613       
+PBSWG   = 0.9597901      CTA      = 0.0007391288   CTP      = 0.0009081566   
+PTA     = 0.001293296    PTP      = 0.001178533    JS       = 2E-06          
+JSW     = 5E-10          CGDO     = cgon           CGSO     = cgon           
+CAPMOD  = 3              NQSMOD   = 0              XPART    = 1              
+CF      = 0              TLEV     = 1              TLEVC    = 1              
+XTI     = 3              N        = 1              HDIF     = hdifn          
+LDIF    = 1.2E-07        RSH      = 4.5            RS       = 0              
+RD      = 0              ACM      = 12             DLC      = 3.49e-9
+DWC     = 5.76e-10       CLC      = 3.82E-08       CLE      = 0.6972
+ACDE    = 0.4            MOIN     = 10             NOFF     = 1.4959
+VOFFCV  = -0.074         CKAPPA   = 2.8769          CGDL    = cgln           
+CGSL    = cgln           CGBO     = 1E-13           TOXM    = 5.4E-9)


.MODEL nch.2            NMOS   (                    LMIN     = '5E-07-dxl'    
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '1.2E-06-dxl'  WMIN     = '1.2E-06-dxw'  WMAX     = 1.01E-04       
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl'    
+NLEV    = 3              AF       = 0.8824         KF       = 3.454E-24      
+XW      = '0+dxw'        VERSION  = 3.2            TOX      = toxn           
+XJ      = 1E-07          NCH      = 1.63E+17       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 2E-08          WINT     = 2E-08          MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '0.480085+dvthn'  LVTH0 = 3.113235E-08   WVTH0    = -1.147539E-08  
+PVTH0   = -1.02578E-14   K1       = 0.3762577      LK1      = 3.056679E-08   
+WK1     = 3.492754E-08   PK1      = -3.255631E-14  K2       = 0.0326151      
+LK2     = -1.300118E-08  WK2      = -1.660542E-08  PK2      = 1.193954E-14   
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 117000         LVSAT    = -0.008329999   
+UA      = -9.285479E-10  LUA      = -1.081538E-16  WUA      = 8.416258E-17   
+PUA     = 1.685491E-23   UB       = 1.882453E-18   LUB      = 7.585749E-26   
+WUB     = -1.971168E-25  PUB      = -3.513499E-32  UC       = 3.98105E-11    
+LUC     = 1.25854E-17    WUC      = -8.34607E-18   PUC      = -5.067005E-24  
+RDSW    = 187            PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.03199188     LU0      = -1.387133E-09  
+WU0     = 1.902013E-09   PU0      = -1.270471E-15  A0       = 0.5916095      
+LA0     = -3.850192E-08  WA0      = -4.52362E-08   PA0      = -6.712484E-15  
+KETA    = -0.008817595   LKETA    = 5.388149E-09   WKETA    = -5.223959E-09  
+PKETA   = 7.789435E-15   A1       = 0              A2       = 0.6875595      
+LA2     = -4.469588E-08  WA2      = -2.840753E-08  PA2      = 3.380497E-14   
+AGS     = 0.01           B0       = 0              B1       = 0              
+VOFF    = -0.1261269     LVOFF    = -9.619418E-09  WVOFF    = -1.316827E-08  
+PVOFF   = 1.559212E-14   NFACTOR  = 1              CIT      = 0.001          
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = -0.0007765884  LETA0    = 1.202293E-09   WETA0    = 2.948919E-10   
+PETA0   = -5.023566E-16  ETAB     = 0.00018        LETAB    = -3.332E-10     
+DSUB    = 0              PCLM     = 0.1508052      LPCLM    = 8.746276E-07   
+WPCLM   = 1.398081E-08   PPCLM    = 1.00513E-13    PDIBLC1  = 1E-05          
+PDIBLC2 = 0.007192272    LPDIBLC2 = -2.608804E-09  WPDIBLC2 = -9.190361E-10  
+PPDIBLC2= 1.093653E-15   PDIBLCB  = 0.01           DROUT    = 0              
+PSCBE1  = 3.241836E+08   LPSCBE1  = 24.20168       WPSCBE1  = -27.30385      
+PPSCBE1 = 1.547794E-05   PSCBE2   = 1E-06          PVAG     = 0              
+DELTA   = 0.01           ALPHA0   = 4.200379E-06   BETA0    = 20.54463       
+KT1     = -0.241585      LKT1     = -1.35838E-08   WKT1     = -7.332996E-09  
+PKT1    = 8.726266E-15   KT2      = -0.03541818    LKT2     = 3.066966E-10   
+WKT2    = -1.312909E-09  PKT2     = 1.093651E-15   AT       = 35000          
+UTE     = -1.765181      LUTE     = 9.497899E-08   WUTE     = 8.147973E-08   
+PUTE    = -3.3357E-14    UA1      = 9.999999E-11   UB1      = 0              
+UC1     = 5.786665E-11   LUC1     = -4.643415E-17  WUC1     = -4.454013E-17  
+PUC1    = 5.956468E-23   KT1L     = 0              PRT      = 0              
+CJ      = cjn            MJ       = 0.4708251      PB       = 0.9597901      
+CJSW    = cjswn          MJSW     = 0.379613       PBSW     = 0.9597901      
+CJSWG   = cjgaten        MJSWG    = 0.379613       PBSWG    = 0.9597901      
+CTA     = 0.0007391288   CTP      = 0.0009081566   PTA      = 0.001293296    
+PTP     = 0.001178533    JS       = 2E-06          JSW      = 5E-10          
+CGDO    = cgon           CGSO     = cgon           CAPMOD   = 3              
+NQSMOD  = 0              XPART    = 1              CF       = 0              
+TLEV    = 1              TLEVC    = 1              XTI      = 3              
+N       = 1              HDIF     = hdifn          LDIF     = 1.2E-07        
+RSH     = 4.5            RS       = 0              RD       = 0              
+ACM     = 12             DLC      = 3.49e-9         DWC     = 5.76e-10       
+CLC     = 3.82E-08       CLE      = 0.6972          ACDE    = 0.4            
+MOIN    = 10             NOFF     = 1.4959          VOFFCV  = -0.074         
+CKAPPA  = 2.8769          CGDL    = cgln           CGSL     = cgln           
+CGBO    = 1E-13           TOXM    = 5.4E-9)


.MODEL nch.3            NMOS   (                    LMIN     = 2.4E-07        
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '5E-07-dxl'    WMIN     = '1.2E-06-dxw'  WMAX     = 1.01E-04       
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl'    
+NLEV    = 3              AF       = 0.8824         KF       = 3.454E-24      
+XW      = '0+dxw'        VERSION  = 3.2            TOX      = toxn           
+XJ      = 1E-07          NCH      = 1.63E+17       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 2E-08          WINT     = 2E-08          MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '0.5486611+dvthn' LVTH0 = -2.469959E-09  WVTH0    = -7.938721E-08  
+PVTH0   = 2.301899E-14   K1       = 0.403429       LK1      = 1.725285E-08   
+WK1     = -3.072359E-08  PK1      = -3.872562E-16  K2       = 0.03135336     
+LK2     = -1.238293E-08  WK2      = 1.859888E-09   PK2      = 2.891545E-15   
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 103237.4       LVSAT    = -0.001586308   
+WVSAT   = -0.003755342   PVSAT    = 1.840118E-09   UA       = -9.466342E-10  
+LUA     = -9.929151E-17  WUA      = 8.099974E-17   PUA      = 1.840469E-23   
+UB      = 1.680473E-18   LUB      = 1.748276E-25   WUB      = -8.461158E-26  
+PUB     = -9.026253E-32  UC       = 4.822789E-11   LUC      = 8.460881E-18   
+WUC     = -2.012348E-17  PUC      = 7.039261E-25   RDSW     = 187            
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.0300978      LU0      = -4.590353E-10  WU0      = 5.920663E-10   
+PU0     = -6.285965E-16  A0       = 0.2606796      LA0      = 1.236537E-07   
+WA0     = 4.002671E-07   PA0      = -2.250091E-13  KETA     = -0.01653278    
+LKETA   = 9.168588E-09   WKETA    = 3.342296E-08   PKETA    = -1.114756E-14  
+A1      = 0              A2       = 0.552563       LA2      = 2.145243E-08   
+WA2     = 9.555396E-08   PA2      = -2.693616E-14  AGS      = 0.02769231     
+LAGS    = -8.669232E-09  B0       = 0              B1       = 0              
+VOFF    = -0.1309933     LVOFF    = -7.23485E-09   WVOFF    = 8.131762E-09   
+PVOFF   = 5.155098E-15   NFACTOR  = 1              CIT      = 0.001          
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = -0.0009629505  LETA0    = 1.29361E-09    WETA0    = -2.950198E-10  
+PETA0   = -2.132999E-16  ETAB     = 0.0007282808   LETAB    = -6.018576E-10  
+WETAB   = -6.831655E-10  PETAB    = 3.347511E-16   DSUB     = 0              
+PCLM    = 1.549809       LPCLM    = 1.89116E-07    WPCLM    = 3.036521E-07   
+PPCLM   = -4.142599E-14  PDIBLC1  = 1E-05          PDIBLC2  = -0.0009022731  
+LPDIBLC2= 1.357523E-09   WPDIBLC2 = 2.474329E-09   PPDIBLC2 = -5.690957E-16  
+PDIBLCB = 0.01           DROUT    = 0              PSCBE1   = 3.595446E+08   
+LPSCBE1 = 6.874803       WPSCBE1  = -5.550639      PPSCBE1  = 4.818866E-06   
+PSCBE2  = 1E-06          PVAG     = 0              DELTA    = 0.01           
+ALPHA0  = 4.200379E-06   BETA0    = 20.54463       KT1      = -0.3197329     
+LKT1    = 2.470867E-08   WKT1     = 6.111851E-08   PKT1     = -2.481497E-14  
+KT2     = -0.03581296    LKT2     = 5.001353E-10   WKT2     = -5.655404E-09  
+PKT2    = 3.221474E-15   AT       = 35000          UTE      = -1.794323      
+LUTE    = 1.092588E-07   WUTE     = 2.077792E-07   PUTE     = -9.524377E-14  
+UA1     = 9.999999E-11   UB1      = 0              UC1      = -6.039701E-11  
+LUC1    = 1.151504E-17   WUC1     = 1.68016E-16    PUC1     = -4.458779E-23  
+KT1L    = 0              PRT      = 0              CJ       = cjn            
+MJ      = 0.4708251      PB       = 0.9597901      CJSW     = cjswn          
+MJSW    = 0.379613       PBSW     = 0.9597901      CJSWG    = cjgaten        
+MJSWG   = 0.379613       PBSWG    = 0.9597901      CTA      = 0.0007391288   
+CTP     = 0.0009081566   PTA      = 0.001293296    PTP      = 0.001178533    
+JS      = 2E-06          JSW      = 5E-10          CGDO     = cgon           
+CGSO    = cgon           CAPMOD   = 3              NQSMOD   = 0              
+XPART   = 1              CF       = 0              TLEV     = 1              
+TLEVC   = 1              XTI      = 3              N        = 1              
+HDIF    = hdifn          LDIF     = 1.2E-07        RSH      = 4.5            
+RS      = 0              RD       = 0              ACM      = 12 
+DLC     = 3.49e-9         DWC     = 5.76e-10        CLC     = 3.82E-08       
+CLE     = 0.6972          ACDE    = 0.4            MOIN     = 10            
+NOFF    = 1.4959          VOFFCV  = -0.074         CKAPPA   = 2.8769         
+CGDL    = cgln           CGSL     = cgln           CGBO     = 1E-13          
+TOXM    = 5.4E-9  )


.MODEL nch.4            NMOS   (                    LMIN     = '1.2E-06-dxl'  
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = 2.1E-05        WMIN     = '6E-07-dxw'    WMAX     = '1.2E-06-dxw'  
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl'    
+NLEV    = 3              AF       = 0.8824         KF       = 3.454E-24      
+XW      = '0+dxw'        VERSION  = 3.2            TOX      = toxn           
+XJ      = 1E-07          NCH      = 1.63E+17       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 2E-08          WINT     = 2E-08          MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '0.4757147+dvthn' LVTH0 = 3.377297E-08   WVTH0    = -1.330241E-08  
+PVTH0   = -5.113942E-15  K1       = 0.4482435      LK1      = -7.666146E-08  
+WK1     = -4.379736E-08  PK1      = 8.614186E-14   K2       = 0.004124679    
+LK2     = 1.931997E-08   WK2      = 1.730959E-08   PK2      = -2.658369E-14  
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 120633         LVSAT    = -0.01265326    
+UA      = -8.774753E-10  LUA      = -9.257552E-17  WUA      = 9.367673E-17   
+PUA     = -8.303838E-23  UB       = 1.732383E-18   LUB      = 1.038218E-25   
+WUB     = -1.380513E-25  PUB      = 6.929437E-32   UC       = 4.39393E-11    
+LUC     = -1.066795E-18  WUC      = -7.763515E-18  PUC      = 4.37691E-24    
+RDSW    = 187            PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.02993191     LU0      = 8.882915E-10   
+WU0     = 9.012331E-10   PU0      = 1.245466E-16   A0       = 0.5194464      
+LA0     = 8.30559E-08    WA0      = 1.293062E-07   PA0      = -2.558111E-13  
+KETA    = 0.003234427    LKETA    = -4.686199E-09  WKETA    = 1.796517E-10   
+PKETA   = -3.59123E-15   A1       = 0              A2       = 0.65           
+AGS     = 0.01           B0       = 0              B1       = 0              
+VOFF    = -0.1378668     LVOFF    = 1.011367E-08   WVOFF    = -9.615865E-09  
+PVOFF   = 4.680216E-15   NFACTOR  = 1              CIT      = -0.0001709485  
+LCIT    = 1.418262E-09   WCIT     = 1.532256E-12   PCIT     = -3.062977E-17  
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = 4.796829E-05   LETA0    = 4.061402E-11   WETA0    = -3.079489E-12  
+PETA0   = 6.155895E-17   ETAB     = -4.68351E-05   LETAB    = -6.326623E-11  
+DSUB    = 0              PCLM     = 0.484661       LPCLM    = 3.066276E-07   
+WPCLM   = -1.676466E-08  PPCLM    = 3.351254E-13   PDIBLC1  = 1E-05          
+PDIBLC2 = 0.000156081    LPDIBLC2 = 6.874929E-09   WPDIBLC2 = 6.853093E-11   
+PPDIBLC2= -1.369924E-15  PDIBLCB  = 0.01           DROUT    = 0              
+PSCBE1  = 1.163897E+08   LPSCBE1  = 228.0433       WPSCBE1  = 2.606975       
+PPSCBE1 = 3.026657E-05   PSCBE2   = 1E-06          PVAG     = 0              
+DELTA   = 0.01           ALPHA0   = 4.200379E-06   BETA0    = 20.54463       
+KT1     = -0.2226133     LKT1     = -3.838151E-08  WKT1     = -9.34664E-09   
+PKT1    = 1.369925E-14   KT2      = -0.02836646    LKT2     = -7.600383E-09  
+WKT2    = -4.204605E-09  PKT2     = 3.972783E-15   AT       = 35000          
+UTE     = -1.647816      LUTE     = -1.705808E-08  WUTE     = 5.575017E-08   
+PUTE    = -3.478553E-14  UA1      = 9.999999E-11   UB1      = 0              
+UC1     = 2.000607E-11   LUC1     = 1.61118E-18    WUC1     = 4.785674E-18   
+PUC1    = -2.602856E-24  KT1L     = 0              PRT      = 0              
+CJ      = cjn            MJ       = 0.4708251      PB       = 0.9597901      
+CJSW    = cjswn          MJSW     = 0.379613       PBSW     = 0.9597901      
+CJSWG   = cjgaten        MJSWG    = 0.379613       PBSWG    = 0.9597901      
+CTA     = 0.0007391288   CTP      = 0.0009081566   PTA      = 0.001293296    
+PTP     = 0.001178533    JS       = 2E-06          JSW      = 5E-10          
+CGDO    = cgon           CGSO     = cgon           CAPMOD   = 3              
+NQSMOD  = 0              XPART    = 1              CF       = 0              
+TLEV    = 1              TLEVC    = 1              XTI      = 3              
+N       = 1              HDIF     = hdifn          LDIF     = 1.2E-07        
+RSH     = 4.5            RS       = 0              RD       = 0              
+ACM     = 12             DLC      = 3.49e-9         DWC     = 5.76e-10       
+CLC     = 3.82E-08       CLE      = 0.6972          ACDE    = 0.4            
+MOIN    = 10             NOFF     = 1.4959          VOFFCV  = -0.074         
+CKAPPA  = 2.8769          CGDL    = cgln            CGSL    = cgln           
+CGBO    = 1E-13           TOXM    = 5.4E-9)


.MODEL nch.5            NMOS   (                    LMIN     = '5E-07-dxl'    
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '1.2E-06-dxl'  WMIN     = '6E-07-dxw'    WMAX     = '1.2E-06-dxw'  
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl'    
+NLEV    = 3              AF       = 0.8824         KF       = 3.454E-24      
+XW      = '0+dxw'        VERSION  = 3.2            TOX      = toxn           
+XJ      = 1E-07          NCH      = 1.63E+17       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 2E-08          WINT     = 2E-08          MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '0.481934+dvthn'  LVTH0 = 2.637191E-08   WVTH0    = -1.362026E-08  
+PVTH0   = -4.735691E-15  K1       = 0.3374388      LK1      = 5.519612E-08   
+WK1     = 7.995742E-08   PK1      = -6.112635E-14  K2       = 0.03707206     
+LK2     = -1.988742E-08  WK2      = -2.177551E-08  PK2      = 1.992759E-14   
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 117000         LVSAT    = -0.008329999   
+UA      = -8.541041E-10  LUA      = -1.203873E-16  WUA      = -2.192285E-18  
+PUA     = 3.104573E-23   UB       = 1.76289E-18    LUB      = 6.751837E-26   
+WUB     = -5.842446E-26  PUB      = -2.546161E-32  UC       = 3.6076E-11     
+LUC     = 8.290533E-18   WUC      = -4.014048E-18  PUC      = -8.495769E-26  
+RDSW    = 187            PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.03247865     LU0      = -2.14233E-09   
+WU0     = 1.337359E-09   PU0      = -3.94443E-16   A0       = 0.598654       
+LA0     = -1.120114E-08  WA0      = -5.340778E-08  PA0      = -3.838139E-14  
+KETA    = -0.00986148    LKETA    = 1.089793E-08   WKETA    = -4.01305E-09   
+PKETA   = 1.398085E-15   A1       = 0              A2       = 0.6459855      
+LA2     = 4.777159E-09   WA2      = 1.981828E-08   PA2      = -2.358376E-14  
+AGS     = 0.01           B0       = 0              B1       = 0              
+VOFF    = -0.1254767     LVOFF    = -4.630622E-09  WVOFF    = -1.39225E-08   
+PVOFF   = 9.805112E-15   NFACTOR  = 1              CIT      = 0.001035476    
+LCIT    = -1.738315E-11  WCIT     = -4.115196E-11  PCIT     = 2.016446E-17   
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = -0.0006976344  LETA0    = 9.278814E-10   WETA0    = 2.033054E-10   
+PETA0   = -1.840392E-16  ETAB     = 0.0001799999   LETAB    = -3.331999E-10  
+DSUB    = 0              PCLM     = 0.1260547      LPCLM    = 7.333693E-07   
+WPCLM   = 4.269131E-08   PPCLM    = 2.643727E-13   PDIBLC1  = 1E-05          
+PDIBLC2 = 0.007986665    LPDIBLC2 = -2.443465E-09  WPDIBLC2 = -1.840532E-09  
+PPDIBLC2= 9.018606E-16   PDIBLCB  = 0.01           DROUT    = 0              
+PSCBE1  = 2.436513E+08   LPSCBE1  = 76.60198       WPSCBE1  = 66.11369       
+PPSCBE1 = -4.530643E-05  PSCBE2   = 1E-06          PVAG     = 0              
+DELTA   = 0.01           ALPHA0   = 4.200379E-06   BETA0    = 20.54463       
+KT1     = -0.2456728     LKT1     = -1.094075E-08  WKT1     = -2.591242E-09  
+PKT1    = 5.660332E-15   KT2      = -0.03822067    LKT2     = 4.126123E-09   
+WKT2    = 1.937973E-09   PKT2     = -3.336885E-15  AT       = 35000          
+UTE     = -1.71088       LUTE     = 5.798823E-08   WUTE     = 1.84915E-08    
+PUTE    = 9.552284E-15   UA1      = 9.999999E-11   UB1      = 0              
+UC1     = 1.964733E-11   LUC1     = 2.038075E-18   WUC1     = -2.05704E-19   
+PUC1    = 3.336885E-24   KT1L     = 0              PRT      = 0              
+CJ      = cjn            MJ       = 0.4708251      PB       = 0.9597901      
+CJSW    = cjswn          MJSW     = 0.379613       PBSW     = 0.9597901      
+CJSWG   = cjgaten        MJSWG    = 0.379613       PBSWG    = 0.9597901      
+CTA     = 0.0007391288   CTP      = 0.0009081566   PTA      = 0.001293296    
+PTP     = 0.001178533    JS       = 2E-06          JSW      = 5E-10          
+CGDO    = cgon           CGSO     = cgon           CAPMOD   = 3              
+NQSMOD  = 0              XPART    = 1              CF       = 0              
+TLEV    = 1              TLEVC    = 1              XTI      = 3              
+N       = 1              HDIF     = hdifn          LDIF     = 1.2E-07        
+RSH     = 4.5            RS       = 0              RD       = 0              
+ACM     = 12             DLC      = 3.49e-9         DWC     = 5.76e-10       
+CLC     = 3.82E-08       CLE      = 0.6972          ACDE    = 0.4            
+MOIN    = 10             NOFF     = 1.4959          VOFFCV  = -0.074         
+CKAPPA  = 2.8769          CGDL    = cgln           CGSL     = cgln          
+CGBO    = 1E-13          TOXM    = 5.4E-9)


.MODEL nch.6            NMOS   (                    LMIN     = 2.4E-07        
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '5E-07-dxl'    WMIN     = '6E-07-dxw'    WMAX     = '1.2E-06-dxw'  
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl'    
+NLEV    = 3              AF       = 0.8824         KF       = 3.454E-24      
+XW      = '0+dxw'        VERSION  = 3.2            TOX      = toxn           
+XJ      = 1E-07          NCH      = 1.63E+17       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 2E-08          WINT     = 2E-08          MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '0.5303662+dvthn' LVTH0 = 2.640164E-09   WVTH0    = -5.816504E-08  
+PVTH0   = 1.709125E-14   K1       = 0.4233184      LK1      = 1.31151E-08    
+WK1     = -5.379541E-08  PK1      = 4.412533E-15   K2       = 0.01368501     
+LK2     = -8.42777E-09   WK2      = 2.235518E-08   PK2      = -1.696441E-15  
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 100000         UA       = -9.441692E-10  
+LUA     = -7.625538E-17  WUA      = 7.814029E-17   PUA      = -8.317222E-24  
+UB      = 1.700655E-18   LUB      = 9.801343E-26   WUB      = -1.080236E-25  
+PUB     = -1.158023E-33  UC       = 2.895671E-11   LUC      = 1.177898E-17   
+WUC     = 2.231078E-18   PUC      = -3.14507E-24   RDSW     = 187            
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.03061502     LU0      = -1.229151E-09  WU0      = -7.907178E-12  
+PU0     = 2.647372E-16   A0       = 0.8197666      LA0      = -1.195463E-07  
+WA0     = -2.482739E-07  PA0      = 5.7103E-14     KETA     = 0.01395927     
+LKETA   = -7.742342E-10  WKETA    = -1.947806E-09  PKETA    = 3.861159E-16   
+A1      = 0              A2       = 0.7194594      LA2      = -3.122499E-08  
+WA2     = -9.804585E-08  PA2      = 3.416966E-14   AGS      = 0.04420383     
+LAGS    = -1.675987E-08  WAGS     = -1.915335E-08  PAGS     = 9.385144E-15   
+B0      = 0              B1       = 0              VOFF     = -0.1320821     
+LVOFF   = -1.393964E-09  WVOFF    = 9.394735E-09   PVOFF    = -1.620331E-15  
+NFACTOR = 1              CIT      = 0.001          CDSC     = 0              
+CDSCB   = 0              CDSCD    = 0              ETA0     = -0.001729269   
+LETA0   = 1.433383E-09   WETA0    = 5.9391E-10     PETA0    = -3.754355E-16  
+ETAB    = 0.0002658953   LETAB    = -3.752887E-10  WETAB    = -1.467984E-10  
+PETAB   = 7.19312E-17    DSUB     = 0              PCLM     = 0.9113339      
+LPCLM   = 3.485825E-07   WPCLM    = 1.044283E-06   PPCLM    = -2.264072E-13  
+PDIBLC1 = 1E-05          PDIBLC2  = 0.001230769    LPDIBLC2 = 8.669232E-10   
+PDIBLCB = 0.01           DROUT    = 0              PSCBE1   = 3.963876E+08   
+LPSCBE1 = 1.761165       WPSCBE1  = -48.28861      PPSCBE1  = 1.075069E-05   
+PSCBE2  = 1E-06          PVAG     = 0              DELTA    = 0.01           
+ALPHA0  = 4.200379E-06   BETA0    = 20.54463       KT1      = -0.2976346     
+LKT1    = 1.452053E-08   WKT1     = 3.54844E-08    PKT1     = -1.299673E-14  
+KT2     = -0.03843019    LKT2     = 4.228789E-09   WKT2     = -2.619415E-09  
+PKT2    = -1.103765E-15  AT       = 35000          UTE      = -1.693497      
+LUTE    = 4.94704E-08    WUTE     = 9.08211E-08    PUTE     = -2.588921E-14  
+UA1     = 9.999999E-11   UB1      = 0              UC1      = 8.935621E-11   
+LUC1    = -3.211927E-17  WUC1     = -5.697779E-18  PUC1     = 6.028002E-24   
+KT1L    = 0              PRT      = 0              CJ       = cjn            
+MJ      = 0.4708251      PB       = 0.9597901      CJSW     = cjswn          
+MJSW    = 0.379613       PBSW     = 0.9597901      CJSWG    = cjgaten        
+MJSWG   = 0.379613       PBSWG    = 0.9597901      CTA      = 0.0007391288   
+CTP     = 0.0009081566   PTA      = 0.001293296    PTP      = 0.001178533    
+JS      = 2E-06          JSW      = 5E-10          CGDO     = cgon           
+CGSO    = cgon           CAPMOD   = 3              NQSMOD   = 0              
+XPART   = 1              CF       = 0              TLEV     = 1              
+TLEVC   = 1              XTI      = 3              N        = 1              
+HDIF    = hdifn          LDIF     = 1.2E-07        RSH      = 4.5            
+RS      = 0              RD       = 0              ACM      = 12             
+DLC      = 3.49e-9        DWC     = 5.76e-10        CLC     = 3.82E-08       
+CLE      = 0.6972         ACDE    = 0.4            MOIN     = 10            
+NOFF     = 1.4959         VOFFCV  = -0.074         CKAPPA   = 2.8769         
+CGDL     = cgln          CGSL     = cgln           CGBO     = 1E-13          
+TOXM    = 5.4E-9)


.MODEL nch.7            NMOS   (                    LMIN     = '1.2E-06-dxl'  
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = 2.1E-05        WMIN     = 3E-07          WMAX     = '6E-07-dxw'    
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl'    
+NLEV    = 3              AF       = 0.8824         KF       = 3.454E-24      
+XW      = '0+dxw'        VERSION  = 3.2            TOX      = toxn           
+XJ      = 1E-07          NCH      = 1.63E+17       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 2E-08          WINT     = 2E-08          MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '0.469492+dvthn'  LVTH0 = 1.360897E-08   WVTH0    = -9.817708E-09  
+PVTH0   = 6.177896E-15   K1       = 0.3375296      LK1      = 1.359622E-07   
+WK1     = 1.82024E-08    PK1      = -3.292741E-14  K2       = 0.04089266     
+LK2     = -4.264537E-08  WK2      = -3.280478E-09  PK2      = 8.116908E-15   
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 120633         LVSAT    = -0.01265326    
+UA      = -8.450057E-10  LUA      = -2.108624E-16  WUA      = 7.549376E-17   
+PUA     = -1.679773E-23  UB       = 1.63455E-18    LUB      = 1.676599E-25   
+WUB     = -8.326477E-26  PUB      = 3.354502E-32   UC       = 3.858849E-11   
+LUC     = 3.428895E-18   WUC      = -4.767065E-18  PUC      = 1.859323E-24   
+RDSW    = 187            PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.03020876     LU0      = 1.714186E-10   
+WU0     = 7.461978E-10   PU0      = 5.259954E-16   A0       = 0.7903264      
+LA0     = -4.283805E-07  WA0      = -2.238654E-08  PA0      = 3.059329E-14   
+KETA    = 0.003558664    LKETA    = -1.116768E-08  WKETA    = -1.921008E-12  
+PKETA   = 3.839989E-17   A1       = 0              A2       = 0.65           
+AGS     = 0.02843049     LAGS     = -2.193229E-08  WAGS     = -1.032108E-08  
+PAGS    = 1.228208E-14   B0       = 0              B1       = 0              
+VOFF    = -0.1688157     LVOFF    = 2.524642E-08   WVOFF    = 7.715525E-09   
+PVOFF   = -3.794123E-15  NFACTOR  = 1              CIT      = -0.0002614005  
+LCIT    = 1.451401E-09   WCIT     = 5.218538E-11   PCIT     = -4.918741E-17  
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = 3.86854E-05    LETA0    = 2.261786E-10   WETA0    = 2.118922E-12   
+PETA0   = -4.235722E-17  ETAB     = -4.68351E-05   LETAB    = -6.326623E-11  
+DSUB    = 0              PCLM     = 0.4489585      LPCLM    = 1.02032E-06    
+WPCLM   = 3.228726E-09   PPCLM    = -6.454244E-14  PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0003333156   LPDIBLC2 = 3.332022E-09   WPDIBLC2 = -3.072054E-11  
+PPDIBLC2= 6.14104E-16    PDIBLCB  = 0.01           DROUT    = 0              
+PSCBE1  = 1.210322E+08   LPSCBE1  = 286.5705       WPSCBE1  = 0.007136342    
+PPSCBE1 = -2.508679E-06  PSCBE2   = 1E-06          PVAG     = 0              
+DELTA   = 0.01           ALPHA0   = 4.200379E-06   BETA0    = 20.54463       
+KT1     = -0.2330176     LKT1     = -1.830499E-08  WKT1     = -3.520215E-09  
+PKT1    = 2.456403E-15   KT2      = -0.04057778    LKT2     = 1.035036E-08   
+WKT2    = 2.633734E-09   PKT2     = -6.079633E-15  AT       = 35000          
+UTE     = -1.659862      LUTE     = 3.421758E-08   WUTE     = 6.249554E-08   
+PUTE    = -6.349991E-14  UA1      = 9.999999E-11   UB1      = 0              
+UC1     = 3.192869E-11   LUC1     = -1.509954E-17  WUC1     = -1.890993E-18  
+PUC1    = 6.755146E-24   KT1L     = 0              PRT      = 0              
+CJ      = cjn            MJ       = 0.4708251      PB       = 0.9597901      
+CJSW    = cjswn          MJSW     = 0.379613       PBSW     = 0.9597901      
+CJSWG   = cjgaten        MJSWG    = 0.379613       PBSWG    = 0.9597901      
+CTA     = 0.0007391288   CTP      = 0.0009081566   PTA      = 0.001293296    
+PTP     = 0.001178533    JS       = 2E-06          JSW      = 5E-10          
+CGDO    = cgon           CGSO     = cgon           CAPMOD   = 3              
+NQSMOD  = 0              XPART    = 1              CF       = 0              
+TLEV    = 1              TLEVC    = 1              XTI      = 3              
+N       = 1              HDIF     = hdifn          LDIF     = 1.2E-07        
+RSH     = 4.5            RS       = 0              RD       = 0              
+ACM     = 12             DLC      = 3.49e-9         DWC     = 5.76e-10       
+CLC     = 3.82E-08       CLE      = 0.6972          ACDE    = 0.4            
+MOIN     = 10            NOFF     = 1.4959          VOFFCV  = -0.074         
+CKAPPA   = 2.8769         CGDL    = cgln           CGSL     = cgln          
+CGBO     = 1E-13          TOXM    = 5.4E-9)


.MODEL nch.8            NMOS   (                    LMIN     = '5E-07-dxl'    
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '1.2E-06-dxl'  WMIN     = 3E-07          WMAX     = '6E-07-dxw'    
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl'    
+NLEV    = 3              AF       = 0.8824         KF       = 3.454E-24      
+XW      = '0+dxw'        VERSION  = 3.2            TOX      = toxn           
+XJ      = 1E-07          NCH      = 1.63E+17       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 2E-08          WINT     = 2E-08          MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '0.4695187+dvthn' LVTH0 = 1.357722E-08   WVTH0    = -6.667661E-09  
+PVTH0   = 2.429339E-15   K1       = 0.5224338      LK1      = -8.407375E-08  
+WK1     = -2.363977E-08  PK1      = 1.686478E-14   K2       = -0.02031804    
+LK2     = 3.019537E-08   WK2      = 1.036295E-08   PK2      = -8.118774E-15  
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 117000         LVSAT    = -0.008329999   
+UA      = -1.030288E-09  LUA      = 9.623759E-18   WUA      = 9.647082E-17   
+PUA     = -4.176045E-23  UB       = 1.757319E-18   LUB      = 2.156438E-26   
+WUB     = -5.530477E-26  PUB      = 2.726316E-34   UC       = 2.756279E-11   
+LUC     = 1.654948E-17   WUC      = 7.533484E-19   PUC      = -4.709972E-24  
+RDSW    = 187            PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.0338842      LU0      = -4.202359E-09  
+WU0     = 5.5025E-10     PU0      = 7.591736E-16   A0       = 0.4609843      
+LA0     = -3.646335E-08  WA0      = 2.368727E-08   PA0      = -2.423456E-14  
+KETA    = -0.02020751    LKETA    = 1.711407E-08   WKETA    = 1.780727E-09   
+PKETA   = -2.082952E-15  A1       = 0              A2       = 0.7760432      
+LA2     = -1.499914E-07  WA2      = -5.301399E-08  PA2      = 6.308667E-14   
+AGS     = 0.01           B0       = 0              B1       = 0              
+VOFF    = -0.1655848     LVOFF    = 2.140156E-08   WVOFF    = 8.538038E-09   
+PVOFF   = -4.772914E-15  NFACTOR  = 1              CIT      = 0.0009290483   
+LCIT    = 3.476632E-11   WCIT     = 1.844744E-11   PCIT     = -9.039244E-18  
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = 0.0002438662   LETA0    = -1.798666E-11  WETA0    = -3.239351E-10  
+PETA0   = 3.456471E-16   ETAB     = 0.00018        LETAB    = -3.332E-10     
+DSUB    = 0              PCLM     = -0.168158      LPCLM    = 1.754689E-06   
+WPCLM   = 2.074505E-07   PPCLM    = -3.075665E-13  PDIBLC1  = 1E-05          
+PDIBLC2 = 0.00444        LPDIBLC2 = -1.554933E-09  WPDIBLC2 = 1.456001E-10   
+PPDIBLC2= 4.042827E-16   PDIBLCB  = 0.01           DROUT    = 0              
+PSCBE1  = 3.838063E+08   LPSCBE1  = -26.13065      WPSCBE1  = -12.37314      
+PPSCBE1 = 1.222385E-05   PSCBE2   = 1E-06          PVAG     = 0              
+DELTA   = 0.01           ALPHA0   = 4.200379E-06   BETA0    = 20.54463       
+KT1     = -0.2440112     LKT1     = -5.222604E-09  WKT1     = -3.5217E-09    
+PKT1    = 2.458171E-15   KT2      = -0.024516      LKT2     = -8.763156E-09  
+WKT2    = -5.736639E-09  PKT2     = 3.881112E-15   AT       = 35000          
+UTE     = -1.690601      LUTE     = 7.079782E-08   WUTE     = 7.135197E-09   
+PUTE    = 2.378916E-15   UA1      = 9.999999E-11   UB1      = 0              
+UC1     = -2.806519E-13  LUC1     = 2.322958E-17   WUC1     = 1.095397E-17   
+PUC1    = -8.530362E-24  KT1L     = 0              PRT      = 0              
+CJ      = cjn            MJ       = 0.4708251      PB       = 0.9597901      
+CJSW    = cjswn          MJSW     = 0.379613       PBSW     = 0.9597901      
+CJSWG   = cjgaten        MJSWG    = 0.379613       PBSWG    = 0.9597901      
+CTA     = 0.0007391288   CTP      = 0.0009081566   PTA      = 0.001293296    
+PTP     = 0.001178533    JS       = 2E-06          JSW      = 5E-10          
+CGDO    = cgon           CGSO     = cgon           CAPMOD   = 3              
+NQSMOD  = 0              XPART    = 1              CF       = 0              
+TLEV    = 1              TLEVC    = 1              XTI      = 3              
+N       = 1              HDIF     = hdifn          LDIF     = 1.2E-07        
+RSH     = 4.5            RS       = 0              RD       = 0              
+ACM     = 12             DLC      = 3.49e-9         DWC     = 5.76e-10       
+CLC     = 3.82E-08       CLE      = 0.6972          ACDE    = 0.4            
+MOIN     = 10            NOFF     = 1.4959          VOFFCV  = -0.074         
+CKAPPA   = 2.8769         CGDL    = cgln           CGSL     = cgln          
+CGBO     = 1E-13          TOXM    = 5.4E-9)


.MODEL nch.9            NMOS   (                    LMIN     = 2.4E-07        
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '5E-07-dxl'    WMIN     = 3E-07          WMAX     = '6E-07-dxw'    
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl'    
+NLEV    = 3              AF       = 0.8824         KF       = 3.454E-24      
+XW      = '0+dxw'        VERSION  = 3.2            TOX      = toxn           
+XJ      = 1E-07          NCH      = 1.63E+17       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 2E-08          WINT     = 2E-08          MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '0.4108627+dvthn' LVTH0 = 4.231861E-08   WVTH0    = 8.756873E-09   
+PVTH0   = -5.128681E-15  K1       = 0.3599899      LK1      = -4.476222E-09  
+WK1     = -1.83314E-08   PK1      = 1.426367E-14   K2       = 0.05063694     
+LK2     = -4.572567E-09  WK2      = 1.662095E-09   PK2      = -3.855355E-15  
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 100000         UA       = -8.486279E-10  
+LUA     = -7.938976E-17  WUA      = 2.463717E-17   PUA      = -6.561966E-24  
+UB      = 1.605935E-18   LUB      = 9.574272E-26   WUB      = -5.498016E-26  
+PUB     = 1.135697E-34   UC       = 5.436336E-11   LUC      = 3.417209E-18   
+WUC     = -1.199664E-17  PUC      = 1.537523E-24   RDSW     = 187            
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.02757004     LU0      = -1.108419E-09  WU0      = 1.697283E-09   
+PU0     = 1.971273E-16   A0       = 0.4631498      LA0      = -3.752444E-08  
+WA0     = -4.856845E-08  PA0      = 1.117074E-14   KETA     = 0.03138113     
+LKETA   = -8.16436E-09   WKETA    = -1.170405E-08  PKETA    = 4.524587E-15   
+A1      = 0              A2       = 0.3458887      LA2      = 6.078422E-08   
+WA2     = 1.111537E-07   PA2      = -1.73555E-14   AGS      = 0.01000276     
+LAGS    = -1.351648E-12  WAGS     = -7.58578E-13   PAGS     = 3.717031E-19   
+B0      = 0              B1       = 0              VOFF     = -0.1187136     
+LVOFF   = -1.5653E-09    WVOFF    = 1.908383E-09   PVOFF    = -1.524383E-15  
+NFACTOR = 1              CIT      = 0.001          CDSC     = 0              
+CDSCB   = 0              CDSCD    = 0              ETA0     = -0.002365929   
+LETA0   = 1.260813E-09   WETA0    = 9.504397E-10   PETA0    = -2.787965E-16  
+ETAB    = -0.0005482135  LETAB    = 2.36245E-11    WETAB    = 3.091024E-10   
+PETAB   = -1.514601E-16  DSUB     = 0              PCLM     = 4.576341       
+LPCLM   = -5.701148E-07  WPCLM    = -1.00812E-06   PPCLM    = 2.880632E-13   
+PDIBLC1 = 1E-05          PDIBLC2  = -0.002035899   LPDIBLC2 = 1.618257E-09   
+WPDIBLC2= 1.829334E-09   PPDIBLC2 = -4.207468E-16  PDIBLCB  = 0.01           
+DROUT   = 0              PSCBE1   = 2.555498E+08   LPSCBE1  = 36.71503       
+WPSCBE1 = 30.58058       PPSCBE1  = -8.823475E-06  PSCBE2   = 1E-06          
+PVAG    = 0              DELTA    = 0.01           ALPHA0   = 4.200379E-06   
+BETA0   = 20.54463       KT1      = -0.2142308     LKT1     = -1.981503E-08  
+WKT1    = -1.122173E-08  PKT1     = 6.231184E-15   KT2      = -0.04077411    
+LKT2    = -7.966823E-10  WKT2     = -1.306815E-09  PKT2     = 1.710499E-15   
+AT      = 35000          UTE      = -1.471602      LUTE     = -3.651167E-08  
+WUTE    = -3.343997E-08  PUTE     = 2.226075E-14   UA1      = 9.999999E-11   
+UB1     = 0              UC1      = 9.165399E-11   LUC1     = -2.181839E-17  
+WUC1    = -6.984539E-18  PUC1     = 2.595069E-25   KT1L     = 0              
+PRT     = 0              CJ       = cjn            MJ       = 0.4708251      
+PB      = 0.9597901      CJSW     = cjswn          MJSW     = 0.379613       
+PBSW    = 0.9597901      CJSWG    = cjgaten        MJSWG    = 0.379613       
+PBSWG   = 0.9597901      CTA      = 0.0007391288   CTP      = 0.0009081566   
+PTA     = 0.001293296    PTP      = 0.001178533    JS       = 2E-06          
+JSW     = 5E-10          CGDO     = cgon           CGSO     = cgon           
+CAPMOD  = 3              NQSMOD   = 0              XPART    = 1              
+CF      = 0              TLEV     = 1              TLEVC    = 1              
+XTI     = 3              N        = 1              HDIF     = hdifn          
+LDIF    = 1.2E-07        RSH      = 4.5            RS       = 0              
+RD      = 0              ACM      = 12             DLC      = 3.49e-9        
+DWC     = 5.76e-10       CLC     = 3.82E-08        CLE      = 0.6972          
+ACDE    = 0.4            MOIN     = 10            NOFF     = 1.4959          
+VOFFCV  = -0.074         CKAPPA   = 2.8769         CGDL    = cgln           
+CGSL     = cgln          CGBO     = 1E-13          TOXM    = 5.4E-9)
*
***************************************************************
*                 PMOS DEVICES MODEL                          *
***************************************************************
.MODEL pch.1            PMOS   (                    LMIN     = '1.2E-06-dxl'  
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = 2.1E-05        WMIN     = '1.2E-06-dxw'  WMAX     = 1.01E-4        
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.2            
+NLEV    = 3              AF       = 1.2828         KF       = 1.184E-23      
+TOX     = toxp           XJ       = 1E-07          NCH      = 4.15E+17       
+LLN     = 1              LWN      = 1              WLN      = 1              
+WWN     = 1              LINT     = 5.2E-08        LL       = 0              
+LW      = 0              LWL      = 0              WINT     = 2.5E-08        
+WL      = 0              WW       = 0              WWL      = 0              
+MOBMOD  = 1              BINUNIT  = 2              XL       = '3E-08+dxl'    
+XW      = '0+dxw'        DWG      = 0              DWB      = 0              
+VTH0    = '-0.5964869+dvthp' LVTH0 = -1.227094E-08  WVTH0    = 5.331006E-09   
+PVTH0   = 4.951822E-15   K1       = 0.6000811      LK1      = -4.272914E-08  
+WK1     = -1.275793E-08  PK1      = 6.864224E-14   K2       = 0.005330595    
+LK2     = 1.236721E-08   WK2      = 4.946015E-09   PK2      = -2.049107E-14  
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 180000         UA       = 6.278216E-10   
+LUA     = -7.532845E-17  WUA      = 1.063208E-16   PUA      = 3.038439E-23   
+UB      = 5.036719E-19   LUB      = 2.151329E-25   WUB      = -2.467893E-25  
+PUB     = -3.285619E-32  UC       = -5.793595E-11  LUC      = 2.487329E-17   
+WUC     = -3.885884E-17  PUC      = 4.396424E-24   RDSW     = 1000           
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.009563554    LU0      = -4.400553E-10  WU0      = 3.135935E-10   
+PU0     = -2.203534E-16  A0       = 0.7584345      LA0      = -1.058737E-07  
+WA0     = 4.878771E-08   PA0      = -2.4806E-14    KETA     = 0.02091301     
+LKETA   = -2.785713E-08  WKETA    = -2.911637E-09  PKETA    = 1.548454E-14   
+A1      = 0              A2       = 0.9            AGS      = 0.01           
+B0      = 0              B1       = 0              VOFF     = -0.1337011     
+LVOFF   = 2.374397E-09   WVOFF    = -3.594663E-09  PVOFF    = 1.62976E-14    
+NFACTOR = 1              CIT      = -0.0001159413  LCIT     = 3.176463E-10   
+WCIT    = 8.992995E-12   PCIT     = -1.791944E-16  CDSC     = 0              
+CDSCB   = 0              CDSCD    = 0              ETA0     = 5E-05          
+ETAB    = -5E-05         DSUB     = 0              PCLM     = 0.5726337      
+LPCLM   = 6.965759E-07   WPCLM    = -1.384238E-07  PPCLM    = 2.927752E-13   
+PDIBLC1 = 1E-05          PDIBLC2  = 0.005          PDIBLCB  = 0.01           
+DROUT   = 0              PSCBE1   = 5E+08          PSCBE2   = 1E-06          
+PVAG    = 0              DELTA    = 0.01           ALPHA0   = 7.7818E-08     
+BETA0   = 19.43759       KT1      = -0.2497616     LKT1     = -5.655294E-09  
+WKT1    = 1.055803E-08   PKT1     = -3.103606E-15  KT2      = -0.02983099    
+LKT2    = -5.4268E-10    WKT2     = 1.542839E-09   PKT2     = -2.182701E-15  
+AT      = 10000          UTE      = -1.037682      LUTE     = 9.182398E-08   
+WUTE    = 6.781937E-09   PUTE     = -6.661502E-15  UA1      = 9.999999E-11   
+UB1     = 0              UC1      = 3.832679E-11   LUC1     = 1.703325E-17   
+WUC1    = 6.655088E-17   PUC1     = -3.097963E-23  KT1L     = 0              
+PRT     = 0              ACM      = 12             HDIF     = hdifp          
+LDIF    = 1.2E-07        RSH      = 3.5            RS       = 0              
+RD      = 0              CJ       = cjp            MJ       = 0.4746122      
+PB      = 0.9522272      CJSW     = cjswp          MJSW     = 0.3296904      
+PBSW    = 0.9522272      CJSWG    = cjgatep        MJSWG    = 0.3296904      
+PBSWG   = 0.9522272      CTA      = 0.0008154354   CTP      = 0.0006079875   
+PTA     = 0.00140666     PTP      = 0.001610754    CGDO     = cgop           
+CGSO    = cgop           CAPMOD   = 3              NQSMOD   = 0              
+XTI     = 3              N        = 1              XPART    = 1              
+CF      = 0              TLEV     = 1              TLEVC    = 1              
+JS      = 7E-07          JSW      = 1.4E-10        DLC      = 4.53e-8      
+DWC     = 2.51e-9        CLC      = 6.60E-08       CLE      = 4.25
+ACDE    = 1.54           MOIN     = 23             NOFF     = 1.855
+VOFFCV  = -0.09          CKAPPA   = 1.1056         CGBO     = 1E-13
+CGDL    = cglp           CGSL     = cglp            TOXM    = 5.4E-9)


.MODEL pch.2            PMOS   (                    LMIN     = '5E-07-dxl'    
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '1.2E-06-dxl'  WMIN     = '1.2E-06-dxw'  WMAX     = 1.01E-4        
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.2            
+NLEV    = 3              AF       = 1.2828         KF       = 1.184E-23      
+TOX     = toxp           XJ       = 1E-07          NCH      = 4.15E+17       
+LLN     = 1              LWN      = 1              WLN      = 1              
+WWN     = 1              LINT     = 5.2E-08        LL       = 0              
+LW      = 0              LWL      = 0              WINT     = 2.5E-08        
+WL      = 0              WW       = 0              WWL      = 0              
+MOBMOD  = 1              BINUNIT  = 2              XL       = '3E-08+dxl'    
+XW      = '0+dxw'        DWG      = 0              DWB      = 0              
+VTH0    = '-0.6205021+dvthp' LVTH0 = 1.47701E-08    WVTH0    = 1.223022E-08   
+PVTH0   = -2.81669E-15   K1       = 0.5002295      LK1      = 6.970379E-08   
+WK1     = 1.320323E-07   PK1      = -9.439152E-14  K2       = 0.03748884     
+LK2     = -2.384297E-08  WK2      = -3.573721E-08  PK2      = 2.531823E-14   
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 186085.7       LVSAT    = -0.006852513   
+UA      = 7.112482E-10   LUA      = -1.692668E-16  WUA      = 1.073025E-16   
+PUA     = 2.927899E-23   UB       = 4.521125E-19   LUB      = 2.731887E-25   
+WUB     = -2.809403E-25  PUB      = 5.597786E-33   UC       = -6.685161E-11  
+LUC     = 3.491232E-17   WUC      = -3.399285E-17  PUC      = -1.082677E-24  
+RDSW    = 1000           PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.009724715    LU0      = -6.215216E-10  
+WU0     = -4.916591E-11  PU0      = 1.881137E-16   A0       = 0.7080865      
+LA0     = -4.918191E-08  WA0      = -2.869854E-08  PA0      = 6.244352E-14   
+KETA    = 0.005343372    LKETA    = -1.032572E-08  WKETA    = 1.510625E-08   
+PKETA   = -4.803599E-15  A1       = 0              A2       = 0.9            
+AGS     = 0.01           B0       = 0              B1       = 0              
+VOFF    = -0.144029      LVOFF    = 1.400361E-08   WVOFF    = 1.88887E-08    
+PVOFF   = -9.018662E-15  NFACTOR  = 1              CIT      = -0.0001956218  
+LCIT    = 4.073665E-10   WCIT     = 1.379719E-10   PCIT     = -3.244246E-16  
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = -4.638704E-05  LETA0    = 1.085318E-10   WETA0    = -1.772073E-11  
+PETA0   = 1.995354E-17   ETAB     = 4.128569E-05   LETAB    = -1.027877E-10  
+DSUB    = 0              PCLM     = 1.221788       LPCLM    = -3.437184E-08  
+WPCLM   = 9.644997E-08   PPCLM    = 2.830743E-14   PDIBLC1  = 1E-05          
+PDIBLC2 = 0.005          PDIBLCB  = 0.01           DROUT    = 0              
+PSCBE1  = 5.264135E+08   LPSCBE1  = -29.7416       WPSCBE1  = 2.528262       
+PPSCBE1 = -2.846821E-06  PSCBE2   = 1E-06          PVAG     = 0              
+DELTA   = 0.01           ALPHA0   = 7.7818E-08     BETA0    = 19.43759       
+KT1     = -0.2660047     LKT1     = 1.263433E-08   WKT1     = 1.65062E-08    
+PKT1    = -9.801244E-15  KT2      = -0.03263429    LKT2     = 2.613835E-09   
+WKT2    = -1.232991E-09  PKT2     = 9.428843E-16   AT       = 10000          
+UTE     = -1.010899      LUTE     = 6.166629E-08   WUTE     = -3.579903E-08  
+PUTE    = 4.128467E-14   UA1      = 9.999999E-11   UB1      = 0              
+UC1     = 8.722802E-11   LUC1     = -3.802953E-17  WUC1     = 5.523177E-17   
+PUC1    = -1.823431E-23  KT1L     = 0              PRT      = 0              
+ACM     = 12             HDIF     = hdifp          LDIF     = 1.2E-07        
+RSH     = 3.5            RS       = 0              RD       = 0              
+CJ      = cjp            MJ       = 0.4746122      PB       = 0.9522272      
+CJSW    = cjswp          MJSW     = 0.3296904      PBSW     = 0.9522272      
+CJSWG   = cjgatep        MJSWG    = 0.3296904      PBSWG    = 0.9522272      
+CTA     = 0.0008154354   CTP      = 0.0006079875   PTA      = 0.00140666     
+PTP     = 0.001610754    CGDO     = cgop           CGSO     = cgop           
+CAPMOD  = 3              NQSMOD   = 0              XTI      = 3              
+N       = 1              XPART    = 1              CF       = 0              
+TLEV    = 1              TLEVC    = 1              JS       = 7E-07          
+JSW     = 1.4E-10        DLC      = 4.53e-8         DWC     = 2.51e-9        
+CLC     = 6.60E-08       CLE      = 4.25            ACDE    = 1.54           
+MOIN    = 23             NOFF     = 1.855           VOFFCV  = -0.09          
+CKAPPA  = 1.1056         CGBO     = 1E-13           CGDL    = cglp           
+CGSL    = cglp            TOXM    = 5.4E-9)


.MODEL pch.3            PMOS   (                    LMIN     = 2.4E-07        
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '5E-07-dxl'    WMIN     = '1.2E-06-dxw'  WMAX     = 1.01E-4        
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.2            
+NLEV    = 3              AF       = 1.2828         KF       = 1.184E-23      
+TOX     = toxp           XJ       = 1E-07          NCH      = 4.15E+17       
+LLN     = 1              LWN      = 1              WLN      = 1              
+WWN     = 1              LINT     = 5.2E-08        LL       = 0              
+LW      = 0              LWL      = 0              WINT     = 2.5E-08        
+WL      = 0              WW       = 0              WWL      = 0              
+MOBMOD  = 1              BINUNIT  = 2              XL       = '3E-08+dxl'    
+XW      = '0+dxw'        DWG      = 0              DWB      = 0              
+VTH0    = '-0.6146093+dvthp' LVTH0 = 1.225977E-08   WVTH0    = 1.985369E-08   
+PVTH0   = -6.06429E-15   K1       = 0.7276184      LK1      = -2.716388E-08  
+WK1     = -1.395578E-07  PK1      = 2.130584E-14   K2       = -0.01029779    
+LK2     = -3.485872E-09  WK2      = 3.685143E-08   PK2      = -5.604526E-15  
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 173192.3       LVSAT    = -0.001359923   
+UA      = 8.541846E-11   LUA      = 9.733665E-17   WUA      = 1.519905E-16   
+PUA     = 1.02419E-23    UB       = 8.476358E-19   LUB      = 1.046959E-25   
+WUB     = -2.65695E-25   PUB      = -8.967035E-34  UC       = -1.847504E-11  
+LUC     = 1.43039E-17    WUC      = -5.906381E-18  PUC      = -1.304751E-23  
+RDSW    = 1000           PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.007833129    LU0      = 1.842939E-10   
+WU0     = 5.259558E-10   PU0      = -5.688812E-17  A0       = 0.5132501      
+LA0     = 3.381841E-08   WA0      = 9.134673E-08   PA0      = 1.130424E-14   
+KETA    = -0.03102319    LKETA    = 5.166434E-09   WKETA    = 7.930221E-09   
+PKETA   = -1.746611E-15  A1       = 0              A2       = 0.8911977      
+LA2     = 3.749746E-09   WA2      = 1.277979E-08   PA2      = -5.44419E-15   
+AGS     = 0.008331296    LAGS     = 7.108682E-10   WAGS     = 1.660363E-08   
+PAGS    = -7.073146E-15  B0       = 0              B1       = 0              
+VOFF    = -0.1054648     LVOFF    = -2.424728E-09  WVOFF    = -1.799239E-08  
+PVOFF   = 6.692681E-15   NFACTOR  = 1              CIT      = 0.0008942893   
+LCIT    = -5.69356E-11   WCIT     = -1.154705E-09  PCIT     = 2.26256E-16    
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = -0.002334355   LETA0    = 1.083206E-09   WETA0    = 1.200188E-10   
+PETA0   = -3.872342E-17  ETAB     = 0.001142361    LETAB    = -5.718457E-10  
+WETAB   = 1.887219E-10   PETAB    = -8.039552E-17  DSUB     = 0              
+PCLM    = 1.04323        LPCLM    = 4.169387E-08   WPCLM    = 2.347217E-07   
+PPCLM   = -3.059635E-14  PDIBLC1  = 1E-05          PDIBLC2  = 0.005          
+PDIBLCB = 0.01           DROUT    = 0              PSCBE1   = 4.512553E+08   
+LPSCBE1 = 2.275782       WPSCBE1  = 8.813572       PPSCBE1  = -5.524364E-06  
+PSCBE2  = 1E-06          PVAG     = 0              DELTA    = 0.01           
+ALPHA0  = 7.7818E-08     BETA0    = 19.43759       KT1      = -0.2149899     
+LKT1    = -9.097961E-09  WKT1     = -1.270587E-08  PKT1     = 2.643099E-15   
+KT2     = -0.03321986    LKT2     = 2.863286E-09   WKT2     = 8.506876E-09   
+PKT2    = -3.206299E-15  AT       = 10000          UTE      = -0.8437479     
+LUTE    = -9.539935E-09  WUTE     = 2.728344E-08   PUTE     = 1.441154E-14   
+UA1     = 4.15469E-10    LUA1     = -1.343898E-16  WUA1     = -3.627893E-16  
+PUA1    = 1.545482E-22   UB1      = 0              UC1      = 2.159457E-11   
+LUC1    = -1.006969E-17  WUC1     = -4.128744E-17  PUC1     = 2.288286E-23   
+KT1L    = 0              PRT      = 0              ACM      = 12             
+HDIF    = hdifp          LDIF     = 1.2E-07        RSH      = 3.5            
+RS      = 0              RD       = 0              CJ       = cjp            
+MJ      = 0.4746122      PB       = 0.9522272      CJSW     = cjswp          
+MJSW    = 0.3296904      PBSW     = 0.9522272      CJSWG    = cjgatep        
+MJSWG   = 0.3296904      PBSWG    = 0.9522272      CTA      = 0.0008154354   
+CTP     = 0.0006079875   PTA      = 0.00140666     PTP      = 0.001610754    
+CGDO    = cgop           CGSO     = cgop           CAPMOD   = 3              
+NQSMOD  = 0              XTI      = 3              N        = 1              
+XPART   = 1              CF       = 0              TLEV     = 1              
+TLEVC   = 1              JS       = 7E-07          JSW      = 1.4E-10        
+DLC     = 4.53e-8         DWC     = 2.51e-9        CLC      = 6.60E-08       
+CLE     = 4.25            ACDE    = 1.54           MOIN     = 23             
+NOFF    = 1.855           VOFFCV  = -0.09          CKAPPA   = 1.1056         
+CGBO    = 1E-13           CGDL    = cglp           CGSL     = cglp        
+TOXM    = 5.4E-9)


.MODEL pch.4            PMOS   (                    LMIN     = '1.2E-06-dxl'  
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = 2.1E-05        WMIN     = '6E-07-dxw'    WMAX     = '1.2E-06-dxw'  
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.2            
+NLEV    = 3              AF       = 1.2828         KF       = 1.184E-23      
+TOX     = toxp           XJ       = 1E-07          NCH      = 4.15E+17       
+LLN     = 1              LWN      = 1              WLN      = 1              
+WWN     = 1              LINT     = 5.2E-08        LL       = 0              
+LW      = 0              LWL      = 0              WINT     = 2.5E-08        
+WL      = 0              WW       = 0              WWL      = 0              
+MOBMOD  = 1              BINUNIT  = 2              XL       = '3E-08+dxl'    
+XW      = '0+dxw'        DWG      = 0              DWB      = 0              
+VTH0    = '-0.5958707+dvthp' LVTH0 = -6.76162E-09   WVTH0    = 4.62241E-09    
+PVTH0   = -1.383898E-15  K1       = 0.5946096      LK1      = 2.357844E-08   
+WK1     = -6.465641E-09  PK1      = -7.611478E-15  K2       = 0.007844382    
+LK2     = -4.83827E-09   WK2      = 2.055159E-09   PK2      = -7.047743E-16  
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 180000         UA       = 6.15269E-10    
+LUA     = 6.747105E-17   WUA      = 1.207563E-16   PUA      = -1.33835E-22   
+UB      = 5.000108E-19   LUB      = 1.92358E-25    WUB      = -2.425791E-25  
+PUB     = -6.665125E-33  UC       = -7.359404E-11  LUC      = 3.611787E-17   
+WUC     = -2.085203E-17  PUC      = -8.534845E-24  RDSW     = 1000           
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.009091901    LU0      = -4.861006E-11  WU0      = 8.559956E-10   
+PU0     = -6.705154E-16  A0       = 0.7691334      LA0      = -1.362008E-07  
+WA0     = 3.648385E-08   PA0      = 1.00701E-14    KETA     = 0.01605329     
+LKETA   = -1.431987E-08  WKETA    = 2.677046E-09   PKETA    = -8.33219E-17   
+A1      = 0              A2       = 0.9            AGS      = 0.01           
+B0      = 0              B1       = 0              VOFF     = -0.1427946     
+LVOFF   = 7.564363E-08   WVOFF    = 6.862818E-09   PVOFF    = -6.796202E-14  
+NFACTOR = 1              CIT      = -0.0001155658  LCIT     = 3.101648E-10   
+WCIT    = 8.561211E-12   PCIT     = -1.705907E-16  CDSC     = 0              
+CDSCB   = 0              CDSCD    = 0              ETA0     = 5E-05          
+ETAB    = -5E-05         DSUB     = 0              PCLM     = 0.4605874      
+LPCLM   = 7.853366E-07   WPCLM    = -9.570443E-09  PPCLM    = 1.907004E-13   
+PDIBLC1 = 1E-05          PDIBLC2  = 0.005          PDIBLCB  = 0.06435359     
+LPDIBLCB= -1.083047E-06  WPDIBLCB = -6.250661E-08  PPDIBLCB = 1.245504E-12   
+DROUT   = 0              PSCBE1   = 5E+08          PSCBE2   = 1E-06          
+PVAG    = 0              DELTA    = 0.01           ALPHA0   = 7.7818E-08     
+BETA0   = 19.43759       KT1      = -0.2518553     LKT1     = -2.884151E-09  
+WKT1    = 1.296568E-08   PKT1     = -6.290419E-15  KT2      = -0.02916964    
+LKT2    = -5.164045E-09  WKT2     = 7.822857E-10   PKT2     = 3.131869E-15   
+AT      = 10000          UTE      = -1.025369      LUTE     = 6.613909E-08   
+WUTE    = -7.377092E-09  PUTE     = 2.287613E-14   UA1      = 9.999999E-11   
+UB1     = 0              UC1      = 1.199823E-10   LUC1     = -7.652936E-17  
+WUC1    = -2.735301E-17  PUC1     = 7.661738E-23   KT1L     = 0              
+PRT     = 0              ACM      = 12             HDIF     = hdifp          
+LDIF    = 1.2E-07        RSH      = 3.5            RS       = 0              
+RD      = 0              CJ       = cjp            MJ       = 0.4746122      
+PB      = 0.9522272      CJSW     = cjswp          MJSW     = 0.3296904      
+PBSW    = 0.9522272      CJSWG    = cjgatep        MJSWG    = 0.3296904      
+PBSWG   = 0.9522272      CTA      = 0.0008154354   CTP      = 0.0006079875   
+PTA     = 0.00140666     PTP      = 0.001610754    CGDO     = cgop           
+CGSO    = cgop           CAPMOD   = 3              NQSMOD   = 0              
+XTI     = 3              N        = 1              XPART    = 1              
+CF      = 0              TLEV     = 1              TLEVC    = 1              
+JS      = 7E-07          JSW      = 1.4E-10        DLC      = 4.53e-8      
+DWC     = 2.51e-9        CLC      = 6.60E-08       CLE      = 4.25
+ACDE    = 1.54           MOIN     = 23             NOFF     = 1.855
+VOFFCV  = -0.09          CKAPPA   = 1.1056         CGBO     = 1E-13
+CGDL    = cglp           CGSL     = cglp            TOXM    = 5.4E-9)


.MODEL pch.5            PMOS   (                    LMIN     = '5E-07-dxl'    
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '1.2E-06-dxl'  WMIN     = '6E-07-dxw'    WMAX     = '1.2E-06-dxw'  
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.2            
+NLEV    = 3              AF       = 1.2828         KF       = 1.184E-23      
+TOX     = toxp           XJ       = 1E-07          NCH      = 4.15E+17       
+LLN     = 1              LWN      = 1              WLN      = 1              
+WWN     = 1              LINT     = 5.2E-08        LL       = 0              
+LW      = 0              LWL      = 0              WINT     = 2.5E-08        
+WL      = 0              WW       = 0              WWL      = 0              
+MOBMOD  = 1              BINUNIT  = 2              XL       = '3E-08+dxl'    
+XW      = '0+dxw'        DWG      = 0              DWB      = 0              
+VTH0    = '-0.6114377+dvthp' LVTH0 = 1.076676E-08   WVTH0    = 1.806206E-09   
+PVTH0   = 1.787149E-15   K1       = 0.6340367      LK1      = -2.081659E-08  
+WK1     = -2.18461E-08   PK1      = 9.706926E-15   K2       = 0.005543762    
+LK2     = -2.247771E-09  WK2      = 9.996362E-10   PK2      = 4.83744E-16    
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 186085.7       LVSAT    = -0.006852513   
+UA      = 9.008309E-10   LUA      = -2.540717E-16  WUA      = -1.107176E-16  
+PUA     = 1.268046E-22   UB       = 4.670627E-19   LUB      = 2.294576E-25   
+WUB     = -2.98133E-25   PUB      = 5.588859E-32   UC       = -7.604286E-11  
+LUC     = 3.887525E-17   WUC      = -2.342289E-17  PUC      = -5.640051E-24  
+RDSW    = 1000           PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.009806256    LU0      = -8.529738E-10  
+WU0     = -1.429379E-10  PU0      = 4.542837E-16   A0       = 0.5789162      
+LA0     = 7.798396E-08   WA0      = 1.198474E-07   PA0      = -8.379726E-14  
+KETA    = 0.01189936     LKETA    = -9.642545E-09  WKETA    = 7.56686E-09    
+PKETA   = -5.589252E-15  A1       = 0              A2       = 0.9            
+AGS     = 0.01           B0       = 0              B1       = 0              
+VOFF    = -0.04149639    LVOFF    = -3.841811E-08  WVOFF    = -9.90238E-08   
+PVOFF   = 5.126632E-14   NFACTOR  = 1              CIT      = 0.0001864417   
+LCIT    = -2.98957E-11   WCIT     = -3.014012E-10  PCIT     = 1.784271E-16   
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = -0.0001363835  LETA0    = 2.098678E-10   WETA0    = 8.577521E-11   
+PETA0   = -9.658291E-17  ETAB     = 9.707135E-05   LETAB    = -1.656024E-10  
+WETAB   = -6.415355E-11  PETAB    = 7.223691E-17   DSUB     = 0              
+PCLM    = 1.01779        LPCLM    = 1.579263E-07   WPCLM    = 3.310475E-07   
+PPCLM   = -1.928355E-13  PDIBLC1  = 1E-05          PDIBLC2  = 0.005          
+PDIBLCB = -1.449778      LPDIBLCB = 6.218654E-07   WPDIBLCB = 1.678745E-06   
+PPDIBLCB= -7.151453E-13  DROUT    = 0              PSCBE1   = 5.548396E+08   
+LPSCBE1 = -61.74943      WPSCBE1  = -30.1618       PPSCBE1  = 3.396219E-05   
+PSCBE2  = 1E-06          PVAG     = 0              DELTA    = 0.01           
+ALPHA0  = 7.7818E-08     BETA0    = 19.43759       KT1      = -0.2714567     
+LKT1    = 1.918703E-08   WKT1     = 2.277602E-08   PKT1     = -1.733686E-14  
+KT2     = -0.04050659    LKT2     = 7.601368E-09   WKT2     = 7.820161E-09   
+PKT2    = -4.792779E-15  AT       = 10000          UTE      = -1.110541      
+LUTE    = 1.620419E-07   WUTE     = 7.878941E-08   PUTE     = -7.414735E-14  
+UA1     = 1E-10          UB1      = 0              UC1      = 1.181789E-10   
+LUC1    = -7.44987E-17   WUC1     = 1.963823E-17   PUC1     = 2.370524E-23   
+KT1L    = 0              PRT      = 0              ACM      = 12             
+HDIF    = hdifp          LDIF     = 1.2E-07        RSH      = 3.5            
+RS      = 0              RD       = 0              CJ       = cjp            
+MJ      = 0.4746122      PB       = 0.9522272      CJSW     = cjswp          
+MJSW    = 0.3296904      PBSW     = 0.9522272      CJSWG    = cjgatep        
+MJSWG   = 0.3296904      PBSWG    = 0.9522272      CTA      = 0.0008154354   
+CTP     = 0.0006079875   PTA      = 0.00140666     PTP      = 0.001610754    
+CGDO    = cgop           CGSO     = cgop           CAPMOD   = 3              
+NQSMOD  = 0              XTI      = 3              N        = 1              
+XPART   = 1              CF       = 0              TLEV     = 1              
+TLEVC   = 1              JS       = 7E-07          JSW      = 1.4E-10       
+DLC     = 4.53e-8         DWC     = 2.51e-9        CLC      = 6.60E-08       
+CLE     = 4.25            ACDE    = 1.54           MOIN     = 23             
+NOFF    = 1.855           VOFFCV  = -0.09          CKAPPA   = 1.1056         
+CGBO    = 1E-13           CGDL    = cglp           CGSL     = cglp        
+TOXM    = 5.4E-9 )


.MODEL pch.6            PMOS   (                    LMIN     = 2.4E-07        
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '5E-07-dxl'    WMIN     = '6E-07-dxw'    WMAX     = '1.2E-06-dxw'  
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.2            
+NLEV    = 3              AF       = 1.2828         KF       = 1.184E-23      
+TOX     = toxp           XJ       = 1E-07          NCH      = 4.15E+17       
+LLN     = 1              LWN      = 1              WLN      = 1              
+WWN     = 1              LINT     = 5.2E-08        LL       = 0              
+LW      = 0              LWL      = 0              WINT     = 2.5E-08        
+WL      = 0              WW       = 0              WWL      = 0              
+MOBMOD  = 1              BINUNIT  = 2              XL       = '3E-08+dxl'    
+XW      = '0+dxw'        DWG      = 0              DWB      = 0              
+VTH0    = '-0.5826022+dvthp' LVTH0 = -1.517161E-09  WVTH0    = -1.695445E-08  
+PVTH0   = 9.779188E-15   K1       = 0.5912579      LK1      = -2.592785E-09  
+WK1     = 1.725682E-08   PK1      = -6.950916E-15  K2       = 0.02634375     
+LK2     = -1.110857E-08  WK2      = -5.286355E-09  PK2      = 3.161577E-15   
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 173192.3       LVSAT    = -0.001359923   
+UA      = -1.286249E-10  LUA      = 1.844765E-16   WUA      = 3.981406E-16   
+PUA     = -8.996896E-23  UB       = 7.273092E-19   LUB      = 1.185926E-25   
+WUB     = -1.273195E-25  PUB      = -1.687796E-32  UC       = 6.303791E-12   
+LUC     = 3.795573E-18   WUC      = -3.440205E-17  PUC      = -9.629313E-25  
+RDSW    = 1000           PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.006821277    LU0      = 4.186273E-10   
+WU0     = 1.689587E-09   PU0      = -3.263717E-16  A0       = 0.7925925      
+LA0     = -1.304218E-08  WA0      = -2.298971E-07  PA0      = 6.519392E-14   
+KETA    = -0.01465939    LKETA    = 1.671481E-09   WKETA    = -1.088816E-08  
+PKETA   = 2.272585E-15   A1       = 0              A2       = 0.9044287      
+LA2     = -1.886638E-09  WA2      = -2.4358E-09    PA2      = 1.037651E-15   
+AGS     = 0.02276923     LAGS     = -5.439693E-09  B0       = 0              
+B1      = 0              VOFF     = -0.1528024     LVOFF    = 8.998269E-09   
+WVOFF   = 3.644589E-08   PVOFF    = -6.443767E-15  NFACTOR  = 1              
+CIT     = -0.0001245626  LCIT     = 1.025921E-10   WCIT     = 1.697424E-11   
+PCIT    = 4.279915E-17   CDSC     = 0              CDSCB    = 0              
+CDSCD   = 0              ETA0     = -0.001725724   LETA0    = 8.869268E-10   
+WETA0   = -5.79907E-10   PETA0    = 1.869977E-16   ETAB     = 0.001075898    
+LETAB   = -5.825824E-10  WETAB    = 2.651543E-10   PETAB    = -6.804834E-17  
+DSUB    = 0              PCLM     = 1.353218       LPCLM    = 1.503402E-08   
+WPCLM   = -1.217646E-07  PPCLM    = 6.247787E-17   PDIBLC1  = 1E-05          
+PDIBLC2 = 0.005          PDIBLCB  = 0.01           DROUT    = 0              
+PSCBE1  = 3.913276E+08   LPSCBE1  = 7.906669       WPSCBE1  = 77.73039       
+PPSCBE1 = -1.199989E-05  PSCBE2   = 1E-06          PVAG     = 0              
+DELTA   = 0.01           ALPHA0   = 7.7818E-08     BETA0    = 19.43759       
+KT1     = -0.1905564     LKT1     = -1.527646E-08  WKT1     = -4.080435E-08  
+PKT1    = 9.748379E-15   KT2      = -0.01907398    LKT2     = -1.528927E-09  
+WKT2    = -7.760885E-09  PKT2     = 1.844746E-15   AT       = 10000          
+UTE     = -0.6544458     LUTE     = -3.22545E-08   WUTE     = -1.90414E-07   
+PUTE    = 4.05333E-14    UA1      = 9.999999E-11   UB1      = 0              
+UC1     = -1.211204E-10  LUC1     = 2.744279E-17   WUC1     = 1.228348E-16   
+PUC1    = -2.02565E-23   KT1L     = 0              PRT      = 0              
+ACM     = 12             HDIF     = hdifp          LDIF     = 1.2E-07        
+RSH     = 3.5            RS       = 0              RD       = 0              
+CJ      = cjp            MJ       = 0.4746122      PB       = 0.9522272      
+CJSW    = cjswp          MJSW     = 0.3296904      PBSW     = 0.9522272      
+CJSWG   = cjgatep        MJSWG    = 0.3296904      PBSWG    = 0.9522272      
+CTA     = 0.0008154354   CTP      = 0.0006079875   PTA      = 0.00140666     
+PTP     = 0.001610754    CGDO     = cgop           CGSO     = cgop           
+CAPMOD  = 3              NQSMOD   = 0              XTI      = 3              
+N       = 1              XPART    = 1              CF       = 0              
+TLEV    = 1              TLEVC    = 1              JS       = 7E-07          
+JSW     = 1.4E-10        DLC      = 4.53e-8         DWC     = 2.51e-9        
+CLC     = 6.60E-08       CLE      = 4.25            ACDE    = 1.54           
+MOIN    = 23             NOFF     = 1.855           VOFFCV  = -0.09          
+CKAPPA  = 1.1056         CGBO     = 1E-13           CGDL    = cglp           
+CGSL    = cglp            TOXM    = 5.4E-9)


.MODEL pch.7            PMOS   (                    LMIN     = '1.2E-06-dxl'  
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = 2.1E-05        WMIN     = 3E-07          WMAX     = '6E-07-dxw'    
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.2            
+NLEV    = 3              AF       = 1.2828         KF       = 1.184E-23      
+TOX     = toxp           XJ       = 1E-07          NCH      = 4.15E+17       
+LLN     = 1              LWN      = 1              WLN      = 1              
+WWN     = 1              LINT     = 5.2E-08        LL       = 0              
+LW      = 0              LWL      = 0              WINT     = 2.5E-08        
+WL      = 0              WW       = 0              WWL      = 0              
+MOBMOD  = 1              BINUNIT  = 2              XL       = '3E-08+dxl'    
+XW      = '0+dxw'        DWG      = 0              DWB      = 0              
+VTH0    = '-0.5940737+dvthp' LVTH0 = -8.252453E-09  WVTH0    = 3.634E-09      
+PVTH0   = -5.639401E-16  K1       = 0.5771518      LK1      = 3.624153E-08   
+WK1     = 3.136116E-09   PK1      = -1.457618E-14  K2       = 0.01319295     
+LK2     = -1.206762E-08  WK2      = -8.865521E-10  PK2      = 3.271368E-15   
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 180000         UA       = 1.200829E-09   
+LUA     = -4.687788E-16  WUA      = -2.013016E-16  PUA      = 1.611024E-22   
+UB      = 3.042403E-20   LUB      = 3.70974E-25    WUB      = 1.569366E-26   
+PUB     = -1.049039E-31  UC       = -1.038957E-10  LUC      = 3.689938E-17   
+WUC     = -4.186143E-18  PUC      = -8.964676E-24  RDSW     = 1000           
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.01077765     LU0      = -1.825951E-09  WU0      = -7.116887E-11  
+PU0     = 3.070219E-16   A0       = 0.7443596      LA0      = -1.732508E-07  
+WA0     = 5.010951E-08   PA0      = 3.044762E-14   KETA     = 0.01880023     
+LKETA   = -9.475532E-09  WKETA    = 1.166228E-09   PKETA    = -2.747705E-15  
+A1      = 0              A2       = 0.9            AGS      = 0.01           
+B0      = 0              B1       = 0              VOFF     = -0.1365031     
+LVOFF   = -9.295147E-08  WVOFF    = 3.402525E-09   PVOFF    = 2.476529E-14   
+NFACTOR = 1              CIT      = -9.499228E-05  LCIT     = -9.978354E-11  
+WCIT    = -2.754239E-12  PCIT     = 5.488095E-17   CDSC     = 0              
+CDSCB   = 0              CDSCD    = 0              ETA0     = 5E-05          
+ETAB    = -5E-05         DSUB     = 0              PCLM     = 0.4207978      
+LPCLM   = 1.578185E-06   WPCLM    = 1.231384E-08   PPCLM    = -2.453662E-13  
+PDIBLC1 = 1E-05          PDIBLC2  = 0.005          PDIBLCB  = -0.09870695    
+LPDIBLCB= 2.166094E-06   WPDIBLCB = 2.717674E-08   PPDIBLCB = -5.415235E-13  
+DROUT   = 0              PSCBE1   = 5E+08          PSCBE2   = 1E-06          
+PVAG    = 0              DELTA    = 0.01           ALPHA0   = 7.7818E-08     
+BETA0   = 19.43759       KT1      = -0.2536715     LKT1     = 1.614478E-08   
+WKT1    = 1.396462E-08   PKT1     = -1.675633E-14  KT2      = -0.05023759    
+LKT2    = 2.78035E-08    WKT2     = 1.236966E-08   PKT2     = -1.500028E-14  
+AT      = 10000          UTE      = -1.091206      LUTE     = 1.995834E-07   
+WUTE    = 2.883275E-08   PUTE     = -5.051824E-14  UA1      = 9.999999E-11   
+UB1     = 0              UC1      = 1.131177E-10   LUC1     = 7.868749E-17   
+WUC1    = -2.357745E-17  PUC1     = -8.751895E-24  KT1L     = 0              
+PRT     = 0              ACM      = 12             HDIF     = hdifp          
+LDIF    = 1.2E-07        RSH      = 3.5            RS       = 0              
+RD      = 0              CJ       = cjp            MJ       = 0.4746122      
+PB      = 0.9522272      CJSW     = cjswp          MJSW     = 0.3296904      
+PBSW    = 0.9522272      CJSWG    = cjgatep        MJSWG    = 0.3296904      
+PBSWG   = 0.9522272      CTA      = 0.0008154354   CTP      = 0.0006079875   
+PTA     = 0.00140666     PTP      = 0.001610754    CGDO     = cgop           
+CGSO    = cgop           CAPMOD   = 3              NQSMOD   = 0              
+XTI     = 3              N        = 1              XPART    = 1              
+CF      = 0              TLEV     = 1              TLEVC    = 1              
+JS      = 7E-07          JSW      = 1.4E-10        DLC      = 4.53e-8      
+DWC     = 2.51e-9        CLC      = 6.60E-08       CLE      = 4.25
+ACDE    = 1.54           MOIN     = 23             NOFF     = 1.855
+VOFFCV  = -0.09          CKAPPA   = 1.1056         CGBO     = 1E-13
+CGDL    = cglp           CGSL     = cglp            TOXM    = 5.4E-9)


.MODEL pch.8            PMOS   (                    LMIN     = '5E-07-dxl'    
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '1.2E-06-dxl'  WMIN     = 3E-07          WMAX     = '6E-07-dxw'    
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.2            
+NLEV    = 3              AF       = 1.2828         KF       = 1.184E-23      
+TOX     = toxp           XJ       = 1E-07          NCH      = 4.15E+17       
+LLN     = 1              LWN      = 1              WLN      = 1              
+WWN     = 1              LINT     = 5.2E-08        LL       = 0              
+LW      = 0              LWL      = 0              WINT     = 2.5E-08        
+WL      = 0              WW       = 0              WWL      = 0              
+MOBMOD  = 1              BINUNIT  = 2              XL       = '3E-08+dxl'    
+XW      = '0+dxw'        DWG      = 0              DWB      = 0              
+VTH0    = '-0.6270721+dvthp' LVTH0 = 2.890378E-08   WVTH0    = 1.040511E-08   
+PVTH0   = -8.188214E-15  K1       = 0.6285072      LK1      = -2.158467E-08  
+WK1     = -1.880486E-08  PK1      = 1.012937E-14   K2       = 0.0005149786   
+LK2     = 2.207774E-09   WK2      = 3.765467E-09   PK2      = -1.966806E-15  
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 186085.7       LVSAT    = -0.006852513   
+UA      = 7.556776E-10   LUA      = 3.24615E-17    WUA      = -3.08833E-17   
+PUA     = -3.078863E-23  UB       = -1.918074E-20  LUB      = 4.26829E-25    
+WUB     = -3.06991E-26   PUB      = -5.266568E-32  UC       = -1.178974E-10  
+LUC     = 5.266533E-17   WUC      = -4.029124E-19  PUC      = -1.32246E-23   
+RDSW    = 1000           PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.008981938    LU0      = 1.960248E-10   
+WU0     = 3.104363E-10   PU0      = -1.226655E-16  A0       = 0.710349       
+LA0     = -1.349549E-07  WA0      = 4.755934E-08   PA0      = 3.331912E-14   
+KETA    = 0.03237266     LKETA    = -2.475809E-08  WKETA    = -3.693456E-09  
+PKETA   = 2.724301E-15   A1       = 0              A2       = 0.9            
+AGS     = -0.0001428509  LAGS     = 1.142085E-08   WAGS     = 5.578569E-09   
+PAGS    = -6.28147E-15   B0       = 0              B1       = 0              
+VOFF    = -0.2959811     LVOFF    = 8.662073E-08   WVOFF    = 4.094279E-08   
+PVOFF   = -1.750504E-14  NFACTOR  = 1              CIT      = -0.0004801657  
+LCIT    = 3.339218E-10   WCIT     = 6.52329E-11    PCIT     = -2.167258E-17  
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = 1.957144E-05   LETA0    = 3.426257E-11   ETAB     = -1.957144E-05  
+LETAB   = -3.426257E-11  DSUB     = 0              PCLM     = 2.39371        
+LPCLM   = -6.433149E-07  WPCLM    = -4.257086E-07  PPCLM    = 2.478472E-13   
+PDIBLC1 = 1E-05          PDIBLC2  = 0.005          PDIBLCB  = 2.929556       
+LPDIBLCB= -1.243731E-06  WPDIBLCB = -7.298891E-07  PPDIBLCB = 3.109328E-13   
+DROUT   = 0              PSCBE1   = 4.660722E+08   LPSCBE1  = 38.20276       
+WPSCBE1 = 18.66032       PPSCBE1  = -2.101152E-05  PSCBE2   = 1E-06          
+PVAG    = 0              DELTA    = 0.01           ALPHA0   = 7.7818E-08     
+BETA0   = 19.43759       KT1      = -0.2200222     LKT1     = -2.174434E-08  
+WKT1    = -5.512935E-09  PKT1     = 5.175397E-15   KT2      = -0.01992055    
+LKT2    = -6.333487E-09  WKT2     = -3.502163E-09  PKT2     = 2.871391E-15   
+AT      = 10000          UTE      = -0.940698      LUTE     = 3.011186E-08   
+WUTE    = -1.462413E-08  PUTE     = -1.585792E-15  UA1      = 9.999999E-11   
+UB1     = 0              UC1      = 2.544602E-10   LUC1     = -8.046421E-17  
+WUC1    = -5.531648E-17  PUC1     = 2.698626E-23   KT1L     = 0              
+PRT     = 0              ACM      = 12             HDIF     = hdifp          
+LDIF    = 1.2E-07        RSH      = 3.5            RS       = 0              
+RD      = 0              CJ       = cjp            MJ       = 0.4746122      
+PB      = 0.9522272      CJSW     = cjswp          MJSW     = 0.3296904      
+PBSW    = 0.9522272      CJSWG    = cjgatep        MJSWG    = 0.3296904      
+PBSWG   = 0.9522272      CTA      = 0.0008154354   CTP      = 0.0006079875   
+PTA     = 0.00140666     PTP      = 0.001610754    CGDO     = cgop           
+CGSO    = cgop           CAPMOD   = 3              NQSMOD   = 0              
+XTI     = 3              N        = 1              XPART    = 1              
+CF      = 0              TLEV     = 1              TLEVC    = 1              
+JS      = 7E-07          JSW      = 1.4E-10        DLC      = 4.53e-8      
+DWC     = 2.51e-9        CLC      = 6.60E-08       CLE      = 4.25
+ACDE    = 1.54           MOIN     = 23             NOFF     = 1.855
+VOFFCV  = -0.09          CKAPPA   = 1.1056         CGBO     = 1E-13
+CGDL    = cglp           CGSL     = cglp            TOXM    = 5.4E-9)


.MODEL pch.9            PMOS   (                    LMIN     = 2.4E-07        
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '5E-07-dxl'    WMIN     = 3E-07          WMAX     = '6E-07-dxw'    
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.2            
+NLEV    = 3              AF       = 1.2828         KF       = 1.184E-23      
+TOX     = toxp           XJ       = 1E-07          NCH      = 4.15E+17       
+LLN     = 1              LWN      = 1              WLN      = 1              
+WWN     = 1              LINT     = 5.2E-08        LL       = 0              
+LW      = 0              LWL      = 0              WINT     = 2.5E-08        
+WL      = 0              WW       = 0              WWL      = 0              
+MOBMOD  = 1              BINUNIT  = 2              XL       = '3E-08+dxl'    
+XW      = '0+dxw'        DWG      = 0              DWB      = 0              
+VTH0    = '-0.5562016+dvthp' LVTH0 = -1.287045E-09  WVTH0    = -3.147479E-08  
+PVTH0   = 9.652624E-15   K1       = 0.6033181      LK1      = -1.08541E-08   
+WK1     = 1.062369E-08   PK1      = -2.407192E-15  K2       = 0.01532588     
+LK2     = -4.101668E-09  WK2      = 7.734788E-10   PK2      = -6.922188E-16  
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 173192.3       LVSAT    = -0.001359923   
+UA      = 1.075863E-09   LUA      = -1.039374E-16  WUA      = -2.643277E-16  
+PUA     = 6.865867E-23   UB       = 4.020718E-19   LUB      = 2.473754E-25   
+WUB     = 5.156102E-26   PUB      = -8.770849E-32  UC       = -1.341845E-11  
+LUC     = 8.157311E-18   WUC      = -2.355482E-17  PUC      = -3.361887E-24  
+RDSW    = 1000           PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.01086406     LU0      = -6.057607E-10  
+WU0     = -5.339471E-10  PU0      = 2.370417E-16   A0       = 0.2543587      
+LA0     = 5.929694E-08   WA0      = 6.613143E-08   PA0      = 2.540741E-14   
+KETA    = -0.03769821    LKETA    = 5.092094E-09   WKETA    = 1.783194E-09   
+PKETA   = 3.91248E-16    A1       = 0              A2       = 0.9            
+AGS     = 0.05007694     LAGS     = -9.972773E-09  WAGS     = -1.501923E-08  
+PAGS    = 2.493193E-15   B0       = 0              B1       = 0              
+VOFF    = -0.07672792    LVOFF    = -6.781112E-09  WVOFF    = -5.395092E-09  
+PVOFF   = 2.234891E-15   NFACTOR  = 1              CIT      = -0.0001323772  
+LCIT    = 1.857639E-10   WCIT     = 2.127227E-11   PCIT     = -2.945352E-18  
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = -0.003249269   LETA0    = 1.426788E-09   WETA0    = 2.580423E-10   
+PETA0   = -1.099259E-16  ETAB     = 0.001712135    LETAB    = -7.719693E-10  
+WETAB   = -8.477567E-11  PETAB    = 3.611443E-17   DSUB     = 0              
+PCLM    = 0.8145576      LPCLM    = 2.940401E-08   WPCLM    = 1.744986E-07   
+PPCLM   = -7.841008E-15  PDIBLC1  = 1E-05          PDIBLC2  = 0.005          
+PDIBLCB = 0.1181169      LPDIBLCB = -4.605777E-08  WPDIBLCB = -5.946426E-08  
+PPDIBLCB= 2.533177E-14   DROUT    = 0              PSCBE1   = 6.54364E+08    
+LPSCBE1 = -42.00954      WPSCBE1  = -66.93957      PPSCBE1  = 1.545402E-05   
+PSCBE2  = 1E-06          PVAG     = 0              DELTA    = 0.01           
+ALPHA0  = 7.7818E-08     BETA0    = 19.43759       KT1      = -0.2845146     
+LKT1    = 5.729426E-09   WKT1     = 1.087265E-08   PKT1     = -1.804859E-15  
+KT2     = -0.05180164    LKT2     = 7.247853E-09   WKT2     = 1.023933E-08   
+PKT2    = -2.982482E-15  AT       = 10000          UTE      = -0.9719581     
+LUTE    = 4.342868E-08   WUTE     = -1.578222E-08  PUTE     = -1.092448E-15  
+UA1     = 9.436022E-11   LUA1     = 2.402534E-18   WUA1     = 3.101871E-18   
+PUA1    = -1.321394E-24  UB1      = 0              UC1      = 1.215723E-10   
+LUC1    = -2.385395E-17  WUC1     = -1.064616E-17  PUC1     = 7.956708E-24   
+KT1L    = 0              PRT      = 0              ACM      = 12             
+HDIF    = hdifp          LDIF     = 1.2E-07        RSH      = 3.5            
+RS      = 0              RD       = 0              CJ       = cjp            
+MJ      = 0.4746122      PB       = 0.9522272      CJSW     = cjswp          
+MJSW    = 0.3296904      PBSW     = 0.9522272      CJSWG    = cjgatep        
+MJSWG   = 0.3296904      PBSWG    = 0.9522272      CTA      = 0.0008154354   
+CTP     = 0.0006079875   PTA      = 0.00140666     PTP      = 0.001610754    
+CGDO    = cgop           CGSO     = cgop           CAPMOD   = 3              
+NQSMOD  = 0              XTI      = 3              N        = 1              
+XPART   = 1              CF       = 0              TLEV     = 1              
+TLEVC   = 1              JS       = 7E-07          JSW      = 1.4E-10       
+DLC     = 4.53e-8         DWC     = 2.51e-9        CLC      = 6.60E-08       
+CLE      = 4.25           ACDE    = 1.54           MOIN     = 23             
+NOFF     = 1.855          VOFFCV  = -0.09          CKAPPA   = 1.1056         
+CGBO     = 1E-13          CGDL    = cglp           CGSL     = cglp        
+TOXM    = 5.4E-9 )
*
.ENDL MOS
*
.LIB MOS_3V
***************************************************************
*                                                             *
*              3.3V NOMINAL VT DEVICES MODEL                  *
*                                                             *
***************************************************************
***************************************************************
*              3.3V NOMINAL VT NMOS DEVICES MODEL             *
***************************************************************
.MODEL nch3.1           NMOS   (                    LMIN     = '1.21E-06-dxl3' 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = 2.1E-05        WMIN     = '1.2E-06-dxw3' WMAX     = 1.01E-04       
+NLEV    = 3              AF       = 0.93           KF       = 8E-24      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3'    
+XW      = '0+dxw3'       VERSION  = 3.1            TOX      = toxn3           
+XJ      = 1E-07          NCH      = 1.8129E+17     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.5E-08        WINT     = 1.5E-08        MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '0.5406846+dvthn3' LVTH0= -1.020427E-08  WVTH0    = -2.621243E-08  
+PVTH0   = 1.50566E-14    K1       = 0.4947621      LK1      = 1.085324E-08   
+WK1     = -1.174025E-08  PK1      = 6.509229E-16   K2       = 0.02701005     
+LK2     = -4.706805E-09  WK2      = 3.608982E-09   PK2      = -2.147224E-15  
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 160643.6       LVSAT    = -0.01287878    
+UA      = -7.469057E-10  LUA      = -1.353155E-16  WUA      = 1.27665E-16    
+PUA     = -1.128382E-22  UB       = 1.869347E-18   LUB      = 2.639187E-26   
+WUB     = -2.362097E-25  PUB      = 4.640422E-32   UC       = 3.746652E-11   
+LUC     = 1.254516E-18   WUC      = -6.956194E-18  PUC      = -4.427724E-24  
+RDSW    = 500            PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.03433713     LU0      = -2.657857E-10  
+WU0     = 8.491092E-10   PU0      = 1.683815E-15   A0       = 0.5154911      
+LA0     = 3.471132E-07   WA0      = 1.742678E-07   PA0      = -1.808066E-13  
+KETA    = 0.005530145    LKETA    = -1.060821E-08  WKETA    = -2.183473E-10  
+PKETA   = 4.369126E-15   A1       = 0              A2       = 0.5041249      
+LA2     = -8.253849E-08  WA2      = -3.661441E-09  PA2      = 7.32653E-14    
+AGS     = 0.01145838     LAGS     = -2.918214E-08  WAGS     = -1.706303E-09  
+PAGS    = 3.414311E-14   B0       = 0              B1       = 0              
+VOFF    = -0.1404081     LVOFF    = 4.486108E-08   WVOFF    = -8.36132E-09   
+PVOFF   = -3.22087E-15   NFACTOR  = 1              CIT      = 0.0004689288   
+LCIT    = 5.501982E-10   WCIT     = -4.503389E-10  PCIT     = 6.092569E-17   
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = 3.486912E-05   LETA0    = 3.027691E-10   WETA0    = 6.740794E-12   
+PETA0   = -1.34883E-16   ETAB     = -3.949003E-05  LETAB    = -2.103046E-10  
+WETAB   = -8.531524E-12  PETAB    = 1.707155E-16   DSUB     = 0              
+PCLM    = 0.6864042      LPCLM    = 2.720522E-07   WPCLM    = -6.572709E-09  
+PPCLM   = 1.315196E-13   PDIBLC1  = 1E-05          PDIBLC2  = 0.0004034229   
+LPDIBLC2= -6.849172E-11  WPDIBLC2 = -3.412609E-11  PPDIBLC2 = 6.828621E-16   
+PDIBLCB = 0.01           DROUT    = 0              PSCBE1   = 1.971203E+08   
+LPSCBE1 = 151.232        WPSCBE1  = -79.89643      PPSCBE1  = 0.0001136554   
+PSCBE2  = 1E-06          PVAG     = 0              DELTA    = 0.01           
+ALPHA0  = 7.67439E-06    BETA0    = 24.9865        KT1      = -0.2784512     
+LKT1    = -2.671761E-08  WKT1     = 5.045015E-08   PKT1     = -5.462898E-14  
+KT2     = -0.02574302    LKT2     = -3.219894E-09  WKT2     = -8.544589E-10  
+PKT2    = 2.387177E-15   AT       = 73988.63       WAT      = -0.03976671    
+UTE     = -1.66465       LUTE     = -6.697351E-08  WUTE     = 8.486214E-08   
+PUTE    = -1.026832E-13  UA1      = 9.999999E-11   UB1      = 0              
+UC1     = -5.602623E-12  LUC1     = 3.424587E-18   WUC1     = 5.486114E-17   
+PUC1    = -3.414311E-23  KT1L     = 0              PRT      = 0              
+CJ      = cjn3           MJ       = 0.34976        PB       = 0.9065364      
+CJSW    = cjswn3         MJSW     = 0.1312098      PBSW     = 0.9065364      
+CJSWG   = cjgaten3       MJSWG    = 0.1312089      PBSWG    = 0.9065364      
+CTA     = 0.0008377299   CTP      = 0.0003438209   PTA      = 0.001899522    
+PTP     = 0.001899522    JS       = 2E-06          JSW      = 8E-11          
+CGDO    = cgon3          CGSO     = cgon3          CAPMOD   = 0              
+NQSMOD  = 0              XPART    = 1              CF       = 0              
+TLEV    = 1              TLEVC    = 1              XTI      = 3              
+N       = 1              HDIF     = hdifn3         LDIF     = 1.2E-07        
+RSH     = 4.5            RS       = 0              RD       = 0              
+ACM     = 12             )


.MODEL nch3.2           NMOS   (                    LMIN     = '6.1E-07-dxl3'  
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '1.21E-06-dxl3' WMIN     = '1.2E-06-dxw3' WMAX     = 1.01E-04       
+NLEV    = 3              AF       = 0.93           KF       = 8E-24      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3'    
+XW      = '0+dxw3'       VERSION  = 3.1            TOX      = toxn3           
+XJ      = 1E-07          NCH      = 1.8129E+17     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.5E-08        WINT     = 1.5E-08        MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '0.5301775+dvthn3' LVTH0= 2.509374E-09   WVTH0    = -2.802886E-08  
+PVTH0   = 1.725448E-14   K1       = 0.4855166      LK1      = 2.204025E-08   
+WK1     = -1.17427E-08   PK1      = 6.538771E-16   K2       = 0.03452649     
+LK2     = -1.380171E-08  WK2      = 1.45492E-09    PK2      = 4.591916E-16   
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 171481.4       LVSAT    = -0.02599249    
+WVSAT   = -0.01323824    PVSAT    = 1.601826E-08   UA       = -9.82285E-10   
+LUA     = 1.494935E-16   WUA      = 2.614118E-16   PUA      = -2.746719E-22  
+UB      = 1.706342E-18   LUB      = 2.236283E-25   WUB      = 9.898344E-26   
+PUB     = -3.591794E-31  UC       = 1.002216E-11   LUC      = 3.446219E-17   
+WUC     = 2.459066E-17   PUC      = -4.259941E-23  RDSW     = 500            
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.03467971     LU0      = -6.803158E-10  WU0      = 2.556983E-09   
+PU0     = -3.827125E-16  A0       = 1.290461       LA0      = -5.906011E-07  
+WA0     = -4.247633E-07  PA0      = 5.440212E-13   KETA     = 0.01371013     
+LKETA   = -2.050598E-08  WKETA    = -2.926565E-08  PKETA    = 3.951636E-14   
+A1      = 0              A2       = 0.3818574      LA2      = 6.540517E-08   
+WA2     = 1.430683E-07   PA2      = -1.042777E-13  AGS      = -0.0153625     
+LAGS    = 3.271124E-09   WAGS     = 5.346413E-08   PAGS     = -3.261312E-14  
+B0      = 0              B1       = 0              VOFF     = -0.1101748     
+LVOFF   = 8.278753E-09   WVOFF    = -1.971152E-08  PVOFF    = 1.051287E-14   
+NFACTOR = 1              CIT      = 0.001007321    LCIT     = -1.012564E-10  
+WCIT    = -6.781778E-10  PCIT     = 3.366108E-16   CDSC     = 0              
+CDSCB   = 0              CDSCD    = 0              ETA0     = -0.0002252589  
+LETA0   = 6.17524E-10    WETA0    = -9.900936E-11  PETA0    = -6.925263E-18  
+ETAB    = 7.818751E-05   LETAB    = -3.526944E-10  WETAB    = 2.673207E-10   
+PETAB   = -1.630656E-16  DSUB     = 0              PCLM     = 0.4462995      
+LPCLM   = 5.625789E-07   WPCLM    = -4.755007E-07  PPCLM    = 6.989224E-13   
+PDIBLC1 = 1E-05          PDIBLC2  = 0.0003738523   LPDIBLC2 = -3.271125E-11  
+WPDIBLC2= 2.606927E-10   PPDIBLC2 = 3.261313E-16   PDIBLCB  = 0.01           
+DROUT   = 0              PSCBE1   = 2.880167E+08   LPSCBE1  = 41.24731       
+WPSCBE1 = 15.11154       PPSCBE1  = -1.304212E-06  PSCBE2   = 1E-06          
+PVAG    = 0              DELTA    = 0.01           ALPHA0   = 7.67439E-06    
+BETA0   = 24.9865        KT1      = -0.3337295     LKT1     = 4.016913E-08   
+WKT1    = 5.246997E-08   PKT1     = -5.707295E-14  KT2      = -0.03546586    
+LKT2    = 8.544739E-09   WKT2     = 1.041196E-09   PKT2     = 9.343445E-17   
+AT      = 73988.63       WAT      = -0.03976671    UTE      = -2.004649      
+LUTE    = 3.444252E-07   WUTE     = 4.052696E-07   PUTE     = -4.903762E-13  
+UA1     = 9.999999E-11   UB1      = 4.441634E-21   LUB1     = -5.374373E-27  
+WUB1    = -4.428306E-26  PUB1     = 5.358251E-32   UC1      = -1.420682E-12  
+LUC1    = -1.635562E-18  WUC1     = 1.31672E-17    PUC1     = 1.630656E-23   
+KT1L    = 0              PRT      = 0              CJ       = cjn3            
+MJ      = 0.34976        PB       = 0.9065364      CJSW     = cjswn3          
+MJSW    = 0.1312098      PBSW     = 0.9065364      CJSWG    = cjgaten3         
+MJSWG   = 0.1312089      PBSWG    = 0.9065364      CTA      = 0.0008377299   
+CTP     = 0.0003438209   PTA      = 0.001899522    PTP      = 0.001899522    
+JS      = 2E-06          JSW      = 8E-11          CGDO     = cgon3           
+CGSO    = cgon3          CAPMOD   = 0              NQSMOD   = 0              
+XPART   = 1              CF       = 0              TLEV     = 1              
+TLEVC   = 1              XTI      = 3              N        = 1              
+HDIF    = hdifn3         LDIF     = 1.2E-07        RSH      = 4.5            
+RS      = 0              RD       = 0              ACM      = 12             )


.MODEL nch3.3           NMOS   (                    LMIN     = 3.5E-07        
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '6.1E-07-dxl3' WMIN     = '1.2E-06-dxw3' WMAX     = 1.01E-04       
+NLEV    = 3              AF       = 0.93           KF       = 8E-24      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3'    
+XW      = '0+dxw3'       VERSION  = 3.1            TOX      = toxn3           
+XJ      = 1E-07          NCH      = 1.8129E+17     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.5E-08        WINT     = 1.5E-08        MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '0.5455576+dvthn3' LVTH0= -6.872467E-09  WVTH0    = -1.472537E-09  
+PVTH0   = 1.055124E-15   K1       = 0.541119       LK1      = -1.187719E-08  
+WK1     = -5.506252E-09  PK1      = -3.150353E-15  K2       = 0.0452837      
+LK2     = -2.03636E-08   WK2      = -7.798026E-10  PK2      = 1.822374E-15   
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 105283.2       LVSAT    = 0.01438841     
+WVSAT   = 0.04061865     PVSAT    = -1.683444E-08  UA       = -1.915685E-09  
+LUA     = 7.188678E-16   WUA      = 6.171433E-16   PUA      = -4.916681E-22  
+UB      = 2.702082E-18   LUB      = -3.837732E-25  WUB      = -8.725E-25     
+PUB     = 2.334254E-31   UC       = 7.629701E-11   LUC      = -5.965469E-18  
+WUC     = -5.398566E-17  PUC      = 5.332144E-24   RDSW     = 500            
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.03137792     LU0      = 1.333776E-09   WU0      = 2.585494E-09   
+PU0     = -4.001036E-16  A0       = 0.5066758      LA0      = -1.124918E-07  
+WA0     = 8.981436E-07   PA0      = -2.629521E-13  KETA     = -0.02108249    
+LKETA   = 7.175143E-10   WKETA    = 3.849357E-08   PKETA    = -1.816763E-15  
+A1      = 0              A2       = 0.5348673      LA2      = -2.793087E-08  
+WA2     = -8.140853E-08  PA2      = 3.265318E-14   AGS      = -0.04050261    
+LAGS    = 1.860659E-08   WAGS     = 3.568806E-08   PAGS     = -2.176972E-14  
+B0      = 0              B1       = 0              VOFF     = -0.09714799    
+LVOFF   = 3.323923E-10   WVOFF    = -1.160734E-08  PVOFF    = 5.569319E-15   
+NFACTOR = 1              CIT      = 0.0006971603   LCIT     = 8.794167E-11   
+WCIT    = 5.85977E-11    PCIT     = -1.128223E-16  CDSC     = 0              
+CDSCB   = 0              CDSCD    = 0              ETA0     = -0.000839361   
+LETA0   = 9.921263E-10   WETA0    = -3.327333E-09  PETA0    = 1.962352E-15   
+ETAB    = 0.000736628    LETAB    = -7.54343E-10   WETAB    = -4.037014E-10  
+PETAB   = 2.462578E-16   DSUB     = 0              PCLM     = 1.046351       
+LPCLM   = 1.965473E-07   WPCLM    = 7.83325E-07    PPCLM    = -6.896125E-14  
+PDIBLC1 = 1E-05          PDIBLC2  = -0.0005948513  LPDIBLC2 = 5.581979E-10   
+WPDIBLC2= 1.865976E-09   PPDIBLC2 = -6.530916E-16  PDIBLCB  = 0.01           
+DROUT   = 0              PSCBE1   = 3.389805E+08   LPSCBE1  = 10.15939       
+WPSCBE1 = -10.86128      PPSCBE1  = 1.453921E-05   PSCBE2   = 1E-06          
+PVAG    = 0              DELTA    = 0.01           ALPHA0   = 7.67439E-06    
+BETA0   = 24.9865        KT1      = -0.2600815     LKT1     = -4.756148E-09  
+WKT1    = -7.85647E-08   PKT1     = 2.28582E-14    KT2      = -0.0186831     
+LKT2    = -1.692743E-09  WKT2     = -5.512367E-09  PKT2     = 4.091108E-15   
+AT      = 73988.63       WAT      = -0.03976671    UTE      = -1.819457      
+LUTE    = 2.314584E-07   WUTE     = -2.393203E-07  PUTE     = -9.71764E-14   
+UA1     = 1.752672E-10   LUA1     = -4.591305E-17  WUA1     = -7.50416E-16   
+PUA1    = 4.577538E-22   UB1      = -1.024991E-20  LUB1     = 3.587466E-27   
+WUB1    = 1.021917E-25   PUB1     = -3.576708E-32  UC1      = -7.556186E-12  
+LUC1    = 2.107096E-18   WUC1     = 7.433824E-17   PUC1     = -2.100778E-23  
+KT1L    = 0              PRT      = 0              CJ       = cjn3            
+MJ      = 0.34976        PB       = 0.9065364      CJSW     = cjswn3          
+MJSW    = 0.1312098      PBSW     = 0.9065364      CJSWG    = cjgaten3         
+MJSWG   = 0.1312089      PBSWG    = 0.9065364      CTA      = 0.0008377299   
+CTP     = 0.0003438209   PTA      = 0.001899522    PTP      = 0.001899522    
+JS      = 2E-06          JSW      = 8E-11          CGDO     = cgon3           
+CGSO    = cgon3          CAPMOD   = 0              NQSMOD   = 0              
+XPART   = 1              CF       = 0              TLEV     = 1              
+TLEVC   = 1              XTI      = 3              N        = 1              
+HDIF    = hdifn3         LDIF     = 1.2E-07        RSH      = 4.5            
+RS      = 0              RD       = 0              ACM      = 12             )


.MODEL nch3.4           NMOS   (                    LMIN     = '1.21E-06-dxl3' 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = 2.1E-05        WMIN     = '6E-07-dxw3'   WMAX     = '1.2E-06-dxw3'  
+NLEV    = 3              AF       = 0.93           KF       = 8E-24      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3'    
+XW      = '0+dxw3'       VERSION  = 3.1            TOX      = toxn3           
+XJ      = 1E-07          NCH      = 1.8129E+17     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.5E-08        WINT     = 1.5E-08        MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '0.5370361+dvthn3' LVTH0= -1.422314E-08  WVTH0    = -2.194369E-08  
+PVTH0   = 1.975867E-14   K1       = 0.5063909      LK1      = 6.155721E-09   
+WK1     = -2.534594E-08  PK1      = 6.147026E-15   K2       = 0.02411514     
+LK2     = -4.96211E-09   WK2      = 6.99602E-09    PK2      = -1.848517E-15  
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 160643.6       LVSAT    = -0.01287878    
+UA      = -6.679708E-10  LUA      = -2.089401E-16  WUA      = 3.531108E-17   
+PUA     = -2.669738E-23  UB       = 1.736013E-18   LUB      = 2.007255E-25   
+WUB     = -8.020915E-26  PUB      = -1.575662E-31  UC       = 3.526407E-11   
+LUC     = 7.842092E-18   WUC      = -4.379322E-18  PUC      = -1.213519E-23  
+RDSW    = 500            PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.0340685      LU0      = 2.433451E-09   
+WU0     = 1.163404E-09   PU0      = -1.474292E-15  A0       = 0.7126326      
+LA0     = 2.666208E-07   WA0      = -5.638778E-08  PA0      = -8.663053E-14  
+KETA    = 0.005340933    LKETA    = -6.822069E-09  WKETA    = 3.031481E-12   
+PKETA   = -6.06568E-17   A1       = 0              A2       = 0.5024803      
+LA2     = -4.963179E-08  WA2      = -1.737351E-09  PA2      = 3.476445E-14   
+AGS     = 0.01           B0       = 0              B1       = 0              
+VOFF    = -0.1529676     LVOFF    = 6.117523E-08   WVOFF    = 6.333253E-09   
+PVOFF   = -2.230842E-14  NFACTOR  = 1              CIT      = 8.970454E-06   
+LCIT    = 6.485917E-10   WCIT     = 8.781248E-11   PCIT     = -5.41947E-17   
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = 4.081793E-05   LETA0    = 1.837335E-10   WETA0    = -2.193256E-13  
+PETA0   = 4.388678E-18   ETAB     = -4.678191E-05  LETAB    = -6.439389E-11  
+DSUB    = 0              PCLM     = 0.6862756      LPCLM    = 2.746246E-07   
+WPCLM   = -6.422264E-09  PPCLM    = 1.285099E-13   PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0004170558   LPDIBLC2 = -3.412877E-10  WPDIBLC2 = -5.007653E-11  
+PPDIBLC2= 1.002033E-15   PDIBLCB  = 0.01           DROUT    = 0              
+PSCBE1  = 1.24865E+08    LPSCBE1  = 245.1902       WPSCBE1  = 4.642158       
+PPSCBE1 = 3.724357E-06   PSCBE2   = 1E-06          PVAG     = 0              
+DELTA   = 0.01           ALPHA0   = 7.67439E-06    BETA0    = 24.9865        
+KT1     = -0.2390299     LKT1     = -5.642908E-08  WKT1     = 4.327322E-09   
+PKT1    = -1.986656E-14  KT2      = -0.03401136    LKT2     = 7.246089E-09   
+WKT2    = 8.819496E-09   PKT2     = -9.858024E-15  AT       = 40000          
+UTE     = -1.619856      LUTE     = -1.671539E-07  WUTE     = 3.245358E-08   
+PUTE    = 1.452788E-14   UA1      = 9.999999E-11   UB1      = 0              
+UC1     = 9.762392E-11   LUC1     = -7.036378E-17  WUC1     = -6.591392E-17  
+PUC1    = 5.21893E-23    KT1L     = 0              PRT      = 0              
+CJ      = cjn3           MJ       = 0.34976        PB       = 0.9065364      
+CJSW    = cjswn3         MJSW     = 0.1312098      PBSW     = 0.9065364      
+CJSWG   = cjgaten3       MJSWG    = 0.1312089      PBSWG    = 0.9065364      
+CTA     = 0.0008377299   CTP      = 0.0003438209   PTA      = 0.001899522    
+PTP     = 0.001899522    JS       = 2E-06          JSW      = 8E-11          
+CGDO    = cgon3          CGSO     = cgon3          CAPMOD   = 0              
+NQSMOD  = 0              XPART    = 1              CF       = 0              
+TLEV    = 1              TLEVC    = 1              XTI      = 3              
+N       = 1              HDIF     = hdifn3         LDIF     = 1.2E-07        
+RSH     = 4.5            RS       = 0              RD       = 0              
+ACM     = 12             )


.MODEL nch3.5           NMOS   (                    LMIN     = '6.1E-07-dxl3'  
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '1.21E-06-dxl3' WMIN     = '6E-07-dxw3'  WMAX     = '1.2E-06-dxw3'  
+NLEV    = 3              AF       = 0.93           KF       = 8E-24      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3'    
+XW      = '0+dxw3'       VERSION  = 3.1            TOX      = toxn3           
+XJ      = 1E-07          NCH      = 1.8129E+17     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.5E-08        WINT     = 1.5E-08        MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '0.4977588+dvthn3' LVTH0= 3.330246E-08   WVTH0    = 9.901029E-09   
+PVTH0   = -1.877343E-14  K1       = 0.504618       LK1      = 8.300913E-09   
+WK1     = -3.409129E-08  PK1      = 1.67289E-14    K2       = 0.0299202      
+LK2     = -1.198623E-08  WK2      = 6.844277E-09   PK2      = -1.664909E-15  
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 169825         LVSAT    = -0.02398825    
+WVSAT   = -0.01130025    PVSAT    = 1.36733E-08    UA       = -7.946072E-10  
+LUA     = -5.571012E-17  WUA      = 4.182859E-17   PUA      = -3.458357E-23  
+UB      = 2.036944E-18   LUB      = -1.634002E-25  WUB      = -2.878208E-25  
+PUB     = 9.364399E-32   UC       = 4.454826E-11   LUC      = -3.391779E-18  
+WUC     = -1.580488E-17  PUC      = 1.68974E-24    RDSW     = 500            
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.03868833     LU0      = -3.15655E-09   WU0      = -2.133102E-09  
+PU0     = 2.514481E-15   A0       = 1.071614       LA0      = -1.677473E-07  
+WA0     = -1.687123E-07  PA0      = 4.928211E-14   KETA     = -0.01160797    
+LKETA   = 1.368611E-08   WKETA    = 3.565347E-10   PKETA    = -4.883957E-16  
+A1      = 0              A2       = 0.446995       LA2      = 1.750541E-08   
+WA2     = 6.68572E-08    PA2      = -4.823496E-14  AGS      = 0.03033333     
+LAGS    = -2.460333E-08  B0       = 0              B1       = 0              
+VOFF    = -0.09572642    LVOFF    = -8.086604E-09  WVOFF    = -3.661614E-08  
+PVOFF   = 2.966034E-14   NFACTOR  = 1              CIT      = 0.0004573953   
+LCIT    = 1.059976E-10   WCIT     = -3.476463E-11  PCIT     = 9.412359E-17   
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = -0.0004577435  LETA0    = 7.869928E-10   WETA0    = 1.729975E-10   
+PETA0   = -2.052037E-16  ETAB     = 0.0005964167   LETAB    = -8.426642E-10  
+WETAB   = -3.390076E-10  PETAB    = 4.101992E-16   DSUB     = 0              
+PCLM    = 0.01958206     LPCLM    = 1.081324E-06   WPCLM    = 2.375871E-08   
+PPCLM   = 9.199081E-14   PDIBLC1  = 1E-05          PDIBLC2  = -0.001227333   
+LPDIBLC2= 1.648423E-09   WPDIBLC2 = 2.13408E-09    PPDIBLC2 = -1.640796E-15  
+PDIBLCB = 0.01           DROUT    = 0              PSCBE1   = 3.089911E+08   
+LPSCBE1 = 22.39764       WPSCBE1  = -9.428542      PPSCBE1  = 2.074991E-05   
+PSCBE2  = 1E-06          PVAG     = 0              DELTA    = 0.01           
+ALPHA0  = 7.67439E-06    BETA0    = 24.9865        KT1      = -0.292188      
+LKT1    = 7.892187E-09   WKT1     = 3.866464E-09   PKT1     = -1.930892E-14  
+KT2     = -0.03445681    LKT2     = 7.785086E-09   WKT2     = -1.393907E-10  
+PKT2    = 9.822289E-16   AT       = 40000          UTE      = -1.656933      
+LUTE    = -1.222913E-07  WUTE     = -1.558155E-09  PUTE     = 5.568208E-14   
+UA1     = 2.427225E-10   LUA1     = -1.726942E-16  WUA1     = -1.669853E-16  
+PUA1    = 2.020522E-22   UB1      = -6.514392E-20  LUB1     = 7.882413E-26   
+WUB1    = 3.713204E-26   PUB1     = -4.492977E-32  UC1      = 2.003033E-11   
+LUC1    = 2.352445E-17   WUC1     = -1.193049E-17  PUC1     = -1.313065E-23  
+KT1L    = 0              PRT      = 0              CJ       = cjn3            
+MJ      = 0.34976        PB       = 0.9065364      CJSW     = cjswn3         
+MJSW    = 0.1312098      PBSW     = 0.9065364      CJSWG    = cjgaten3         
+MJSWG   = 0.1312089      PBSWG    = 0.9065364      CTA      = 0.0008377299   
+CTP     = 0.0003438209   PTA      = 0.001899522    PTP      = 0.001899522    
+JS      = 2E-06          JSW      = 8E-11          CGDO     = cgon3           
+CGSO    = cgon3          CAPMOD   = 0              NQSMOD   = 0              
+XPART   = 1              CF       = 0              TLEV     = 1              
+TLEVC   = 1              XTI      = 3              N        = 1              
+HDIF    = hdifn3         LDIF     = 1.2E-07        RSH      = 4.5            
+RS      = 0              RD       = 0              ACM      = 12             )


.MODEL nch3.6           NMOS   (                    LMIN     = 3.5E-07        
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '6.1E-07-dxl3' WMIN     = '6E-07-dxw3'   WMAX     = '1.2E-06-dxw3'  
+NLEV    = 3              AF       = 0.93           KF       = 8E-24      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3'    
+XW      = '0+dxw3'       VERSION  = 3.1            TOX      = toxn3           
+XJ      = 1E-07          NCH      = 1.8129E+17     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.5E-08        WINT     = 1.5E-08        MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '0.5443791+dvthn3' LVTH0= 4.864093E-09   WVTH0    = -9.369332E-11  
+PVTH0   = -1.267665E-14  K1       = 0.5522911      LK1      = -2.077966E-08  
+WK1     = -1.857758E-08  PK1      = 7.265538E-15   K2       = 0.03791251     
+LK2     = -1.686154E-08  WK2      = 7.844484E-09   PK2      = -2.275036E-15  
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 117711.5       LVSAT    = 0.007800961    
+WVSAT   = 0.0260775      PVSAT    = -9.127126E-09  UA       = -1.345257E-09  
+LUA     = 2.801863E-16   WUA      = -5.025796E-17  PUA      = 2.158922E-23   
+UB      = 1.821078E-18   LUB      = -3.172244E-26  WUB      = 1.582742E-25   
+PUB     = -1.78474E-31   UC       = 2.700182E-11   LUC      = 7.311549E-18   
+WUC     = 3.68972E-18    PUC      = -1.020197E-23  RDSW     = 500            
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.0275355      LU0      = 3.646679E-09   WU0      = 7.08113E-09    
+PU0     = -3.1062E-15    A0       = 1.489285       LA0      = -4.225262E-07  
+WA0     = -2.515091E-07  PA0      = 9.978817E-14   KETA     = 0.02738997     
+LKETA   = -1.010264E-08  WKETA    = -1.821923E-08  PKETA    = 1.084282E-14   
+A1      = 0              A2       = 0.5246792      LA2      = -2.988191E-08  
+WA2     = -6.948847E-08  PA2      = 3.49359E-14    AGS      = -0.01          
+B0      = 0              B1       = 0              VOFF     = -0.1307932     
+LVOFF   = 1.330413E-08   WVOFF    = 2.775756E-08   PVOFF    = -9.607615E-15  
+NFACTOR = 1              CIT      = 0.0006801422   LCIT     = -2.987805E-11  
+WCIT    = 7.850881E-11   PCIT     = 2.502679E-17   CDSC     = 0              
+CDSCB   = 0              CDSCD    = 0              ETA0     = -0.005840984   
+LETA0   = 4.070769E-09   WETA0    = 2.524566E-09   PETA0    = -1.63966E-15   
+ETAB    = -0.0001380421  LETAB    = -3.946444E-10  WETAB    = 6.196625E-10   
+PETAB   = -1.745896E-16  DSUB     = 0              PCLM     = 1.590286       
+LPCLM   = 1.231943E-07   WPCLM    = 1.469211E-07   PPCLM    = 1.686176E-14   
+PDIBLC1 = 1E-05          PDIBLC2  = 0.002114423    LPDIBLC2 = -3.90048E-10   
+WPDIBLC2= -1.303875E-09  PPDIBLC2 = 4.563563E-16   PDIBLCB  = 0.01           
+DROUT   = 0              PSCBE1   = 2.780378E+08   LPSCBE1  = 41.27919       
+WPSCBE1 = 60.44173       PPSCBE1  = -2.187096E-05  PSCBE2   = 1E-06          
+PVAG    = 0              DELTA    = 0.01           ALPHA0   = 7.67439E-06    
+BETA0   = 24.9865        KT1      = -0.2970865     LKT1     = 1.08803E-08    
+WKT1    = -3.526875E-08  PKT1     = 4.563559E-15   KT2      = -0.02815429    
+LKT2    = 3.940551E-09   WKT2     = 5.568928E-09   PKT2     = -2.499846E-15  
+AT      = 40000          UTE      = -1.98652       LUTE     = 7.875715E-08   
+WUTE    = -4.385647E-08  PUTE     = 8.148405E-14   UA1      = -5.687268E-10  
+LUA1    = 3.222899E-16   WUA1     = 1.200572E-16   PUA1     = 2.695624E-23   
+UB1     = 1.503321E-19   LUB1     = -5.261623E-26  WUB1     = -8.568932E-26  
+PUB1    = 2.999126E-32   UC1      = 1.092575E-10   LUC1     = -3.090412E-17  
+WUC1    = -6.233378E-17  PUC1     = 1.761535E-23   KT1L     = 0              
+PRT     = 0              CJ       = cjn3           MJ       = 0.34976        
+PB      = 0.9065364      CJSW     = cjswn3         MJSW     = 0.1312098      
+PBSW    = 0.9065364      CJSWG    = cjgaten3       MJSWG    = 0.1312089      
+PBSWG   = 0.9065364      CTA      = 0.0008377299   CTP      = 0.0003438209   
+PTA     = 0.001899522    PTP      = 0.001899522    JS       = 2E-06          
+JSW     = 8E-11          CGDO     = cgon3          CGSO     = cgon3           
+CAPMOD  = 0              NQSMOD   = 0              XPART    = 1              
+CF      = 0              TLEV     = 1              TLEVC    = 1              
+XTI     = 3              N        = 1              HDIF     = hdifn3          
+LDIF    = 1.2E-07        RSH      = 4.5            RS       = 0              
+RD      = 0              ACM      = 12             )


.MODEL nch3.7           NMOS   (                    LMIN     = '1.21E-06-dxl3' 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = 2.1E-05        WMIN     = 3E-07          WMAX     = '6E-07-dxw3'    
+NLEV    = 3              AF       = 0.93           KF       = 8E-24      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3'    
+XW      = '0+dxw3'       VERSION  = 3.1            TOX      = toxn3           
+XJ      = 1E-07          NCH      = 1.8129E+17     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.5E-08        WINT     = 1.5E-08        MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '0.5277748+dvthn3' LVTH0= 2.219145E-08   WVTH0    = -1.66647E-08   
+PVTH0   = -9.976447E-16  K1       = 0.4753582      LK1      = 8.054953E-09   
+WK1     = -7.657285E-09  PK1      = 5.064463E-15   K2       = 0.03041754     
+LK2     = -1.795747E-09  WK2      = 3.403653E-09   PK2      = -3.653345E-15  
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 160643.6       LVSAT    = -0.01287878    
+UA      = -6.860687E-10  LUA      = -2.352568E-16  WUA      = 4.562689E-17   
+PUA     = -1.169685E-23  UB       = 1.71589E-18    LUB      = -4.901843E-26  
+WUB     = -6.873868E-26  PUB      = -1.521211E-32  UC       = 3.309738E-11   
+LUC     = -5.639712E-18  WUC      = -3.144308E-18  PUC      = -4.450561E-24  
+RDSW    = 500            PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.03467042     LU0      = -2.060785E-09  
+WU0     = 8.20311E-10    PU0      = 1.087422E-15   A0       = 0.4926052      
+LA0     = 1.799379E-07   WA0      = 6.902788E-08   PA0      = -3.722124E-14  
+KETA    = 0.005497491    LKETA    = -9.954786E-09  WKETA    = -8.620687E-11  
+PKETA   = 1.724993E-15   A1       = 0              A2       = 0.4999195      
+LA2     = 1.611097E-09   WA2      = -2.776617E-10  PA2      = 5.556E-15      
+AGS     = 0.01           B0       = 0              B1       = 0              
+VOFF    = -0.1405014     LVOFF    = 2.800236E-09   WVOFF    = -7.724833E-10  
+PVOFF   = 1.096533E-14   NFACTOR  = 1              CIT      = 0.0001396452   
+LCIT    = 5.429783E-10   WCIT     = 1.332785E-11   PCIT     = 6.004901E-18   
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = 3.182291E-05   LETA0    = 3.637225E-10   WETA0    = 4.907817E-12   
+PETA0   = -9.820509E-17  ETAB     = -4.388563E-05  LETAB    = -1.223484E-10  
+WETAB   = -1.650881E-12  PETAB    = 3.303407E-17   DSUB     = 0              
+PCLM    = 0.7040325      LPCLM    = -8.06892E-08   WPCLM    = -1.65437E-08   
+PPCLM   = 3.310387E-13   PDIBLC1  = 1E-05          PDIBLC2  = 0.000358165    
+LPDIBLC2= 8.371203E-10   WPDIBLC2 = -1.650881E-11  PPDIBLC2 = 3.303407E-16   
+PDIBLCB = 0.01           DROUT    = 0              PSCBE1   = 1.464472E+08   
+LPSCBE1 = 263.5749       WPSCBE1  = -7.65964       PPSCBE1  = -6.75489E-06   
+PSCBE2  = 1E-06          PVAG     = 0              DELTA    = 0.01           
+ALPHA0  = 7.67439E-06    BETA0    = 24.9865        KT1      = -0.2390507     
+LKT1    = -8.30281E-08   WKT1     = 4.339137E-09   PKT1     = -4.705113E-15  
+KT2     = -0.01789639    LKT2     = -1.32684E-08   WKT2     = -3.66038E-10   
+PKT2    = 1.835234E-15   AT       = 40000          UTE      = -1.633485      
+LUTE    = -5.391607E-08  WUTE     = 4.022191E-08   PUTE     = -5.00177E-14   
+UA1     = 9.999999E-11   UB1      = 0              UC1      = -5.214002E-11  
+LUC1    = 4.932561E-17   WUC1     = 1.945153E-17   PUC1     = -1.603366E-23  
+KT1L    = 0              PRT      = 0              CJ       = cjn3            
+MJ      = 0.34976        PB       = 0.9065364      CJSW     = cjswn3          
+MJSW    = 0.1312098      PBSW     = 0.9065364      CJSWG    = cjgaten3         
+MJSWG   = 0.1312089      PBSWG    = 0.9065364      CTA      = 0.0008377299   
+CTP     = 0.0003438209   PTA      = 0.001899522    PTP      = 0.001899522    
+JS      = 2E-06          JSW      = 8E-11          CGDO     = cgon3           
+CGSO    = cgon3          CAPMOD   = 0              NQSMOD   = 0              
+XPART   = 1              CF       = 0              TLEV     = 1              
+TLEVC   = 1              XTI      = 3              N        = 1              
+HDIF    = hdifn3         LDIF     = 1.2E-07        RSH      = 4.5            
+RS      = 0              RD       = 0              ACM      = 12             )


.MODEL nch3.8           NMOS   (                    LMIN     = '6.1E-07-dxl3'  
+LMAX    = '1.21E-06-dxl3' WMIN    = 3E-07          WMAX     = '6E-07-dxw3'    
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+NLEV    = 3              AF       = 0.93           KF       = 8E-24      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3'    
+XW      = '0+dxw3'       VERSION  = 3.1            TOX      = toxn3           
+XJ      = 1E-07          NCH      = 1.8129E+17     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.5E-08        WINT     = 1.5E-08        MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '0.5674067+dvthn3' LVTH0= -2.576322E-08  WVTH0    = -2.97983E-08   
+PVTH0   = 1.489401E-14   K1       = 0.4085097      LK1      = 8.894157E-08   
+WK1     = 2.069043E-08   PK1      = -2.923628E-14  K2       = 0.05467615     
+LK2     = -3.114867E-08  WK2      = -7.266618E-09  PK2      = 9.257685E-15   
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 140850         LVSAT    = 0.0110715      
+WVSAT   = 0.0052155      PVSAT    = -6.310755E-09  UA       = -8.79095E-10   
+LUA     = -1.695052E-18  WUA      = 8.998666E-17   PUA      = -6.537217E-23  
+UB      = 1.6279E-18     LUB      = 5.744965E-26   WUB      = -5.466566E-26  
+PUB     = -3.224046E-32  UC       = 2.307989E-11   LUC      = 6.481454E-18   
+WUC     = -3.567908E-18  PUC      = -3.938004E-24  RDSW     = 500            
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.03048008     LU0      = 3.009521E-09   WU0      = 2.545602E-09   
+PU0     = -1.00018E-15   A0       = 0.674562       LA0      = -4.022983E-08  
+WA0     = 5.760773E-08   PA0      = -2.340287E-14  KETA     = -0.01555151    
+LKETA   = 1.55145E-08    WKETA    = 2.604349E-09   PKETA    = -1.530581E-15  
+A1      = 0              A2       = 0.5788834      LA2      = -9.393527E-08  
+WA2     = -8.319181E-09  PA2      = 1.528624E-14   AGS      = 0.03033333     
+LAGS    = -2.460333E-08  B0       = 0              B1       = 0              
+VOFF    = -0.2001448     LVOFF    = 7.496869E-08   WVOFF    = 2.290232E-08   
+PVOFF   = -1.768119E-14  NFACTOR  = 1              CIT      = 0.0004772922   
+LCIT    = 1.344255E-10   WCIT     = -4.610587E-11  PCIT     = 7.791968E-17   
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = -0.0001339544  LETA0    = 5.643132E-10   WETA0    = -1.156227E-11  
+PETA0   = -7.827629E-17  ETAB     = -8.908331E-05  LETAB    = -6.765919E-11  
+WETAB   = 5.172749E-11   PETAB    = -3.155377E-17  DSUB     = 0              
+PCLM    = -0.371167      LPCLM    = 1.220302E-06   WPCLM    = 2.464858E-07   
+PPCLM   = 1.277309E-14   PDIBLC1  = 1E-05          PDIBLC2  = 0.002981666    
+LPDIBLC2= -2.337316E-09  WPDIBLC2 = -2.650498E-10  PPDIBLC2 = 6.310754E-16   
+PDIBLCB = 0.01           DROUT    = 0              PSCBE1   = 3.156818E+08   
+LPSCBE1 = 58.80091       WPSCBE1  = -13.24223      PSCBE2   = 1E-06          
+PVAG    = 0              DELTA    = 0.01           ALPHA0   = 7.67439E-06    
+BETA0   = 24.9865        KT1      = -0.272359      LKT1     = -4.2725E-08    
+WKT1    = -7.436058E-09  PKT1     = 9.542876E-15   KT2      = -0.03978835    
+LKT2    = 1.322087E-08   WKT2     = 2.899585E-09   PKT2     = -2.11617E-15   
+AT      = 40000          UTE      = -1.582522      LUTE     = -1.155819E-07  
+WUTE    = -4.397266E-08  PUTE     = 5.185773E-14   UA1      = 3.061562E-11   
+LUA1    = 8.395508E-17   WUA1     = -4.60844E-17   PUA1     = 5.576213E-23   
+UB1     = 0              UC1      = -2.283801E-11  LUC1     = 1.387018E-17   
+WUC1    = 1.250447E-17   PUC1     = -7.627725E-24  KT1L     = 0              
+PRT     = 0              CJ       = cjn3           MJ       = 0.34976        
+PB      = 0.9065364      CJSW     = cjswn3         MJSW     = 0.1312098      
+PBSW    = 0.9065364      CJSWG    = cjgaten3       MJSWG    = 0.1312089      
+PBSWG   = 0.9065364      CTA      = 0.0008377299   CTP      = 0.0003438209   
+PTA     = 0.001899522    PTP      = 0.001899522    JS       = 2E-06          
+JSW     = 8E-11          CGDO     = cgon3          CGSO     = cgon3           
+CAPMOD  = 0              NQSMOD   = 0              XPART    = 1              
+CF      = 0              TLEV     = 1              TLEVC    = 1              
+XTI     = 3              N        = 1              HDIF     = hdifn3          
+LDIF    = 1.2E-07        RSH      = 4.5            RS       = 0              
+RD      = 0              ACM      = 12             )


.MODEL nch3.9           NMOS   (                    LMIN     = 3.5E-07        
+LMAX    = '6.1E-07-dxl3' WMIN     = 3E-07          WMAX     = '6E-07-dxw3'    
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+NLEV    = 3              AF       = 0.93           KF       = 8E-24      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3'    
+XW      = '0+dxw3'       VERSION  = 3.1            TOX      = toxn3           
+XJ      = 1E-07          NCH      = 1.8129E+17     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.5E-08        WINT     = 1.5E-08        MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '0.4701889+dvthn3' LVTH0= 3.353962E-08   WVTH0    = 4.219467E-08   
+PVTH0   = -2.902171E-14  K1       = 0.5097731      LK1      = 2.71709E-08    
+WK1     = 5.657654E-09   PK1      = -2.006629E-14  K2       = 0.04803817     
+LK2     = -2.709951E-08  WK2      = 2.072856E-09   PK2      = 3.560606E-15   
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 184576.9       LVSAT    = -0.01560192    
+WVSAT   = -0.01203577    PVSAT    = 4.212518E-09   UA       = -1.850006E-09  
+LUA     = 5.905606E-16   WUA      = 2.374489E-16   PUA      = -1.553242E-22  
+UB      = 2.156753E-18   LUB      = -2.651506E-25  WUB      = -3.305994E-26  
+PUB     = -4.541996E-32  UC       = 5.626878E-12   LUC      = 1.712779E-17   
+WUC     = 1.587344E-17   PUC      = -1.579723E-23  RDSW     = 500            
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.0408386      LU0      = -3.309175E-09  WU0      = -5.016392E-10  
+PU0     = 8.586373E-16   A0       = 0.9196515      LA0      = -1.897344E-07  
+WA0     = 7.318199E-08   PA0      = -3.290317E-14  KETA     = 0.01905888     
+LKETA   = -5.597836E-09  WKETA    = -1.34705E-08   PKETA    = 8.275081E-15   
+A1      = 0              A2       = 0.4056701      LA2      = 1.172486E-08   
+WA2     = -1.653275E-09  PA2      = 1.122004E-14   AGS      = -0.01          
+B0      = 0              B1       = 0              VOFF     = -0.1270323     
+LVOFF   = 3.037011E-08   WVOFF    = 2.561385E-08   PVOFF    = -1.933523E-14  
+NFACTOR = 1              CIT      = 0.0006539662   LCIT     = 2.665433E-11   
+WCIT    = 9.342913E-11   PCIT     = -7.196669E-18  CDSC     = 0              
+CDSCB   = 0              CDSCD    = 0              ETA0     = -0.0001567203  
+LETA0   = 5.782002E-10   WETA0    = -7.154647E-10  PETA0    = 3.511042E-16   
+ETAB    = 0.001014031    LETAB    = -7.405588E-10  WETAB    = -3.701912E-11  
+PETAB   = 2.258167E-17   DSUB     = 0              PCLM     = 1.994147       
+LPCLM   = -2.225397E-07  WPCLM    = -8.327995E-08  PPCLM    = 2.139302E-13   
+PDIBLC1 = 1E-05          PDIBLC2  = -0.002128846   LPDIBLC2 = 7.800959E-10   
+WPDIBLC2= 1.114788E-09   PPDIBLC2 = -2.106259E-16  PDIBLCB  = 0.01           
+DROUT   = 0              PSCBE1   = 4.256887E+08   LPSCBE1  = -8.303286      
+WPSCBE1 = -23.71931      PPSCBE1  = 6.391057E-06   PSCBE2   = 1E-06          
+PVAG    = 0              DELTA    = 0.01           ALPHA0   = 7.67439E-06    
+BETA0   = 24.9865        KT1      = -0.3043039     LKT1     = -2.323864E-08  
+WKT1    = -3.115488E-08  PKT1     = 2.401136E-14   KT2      = -0.01805768    
+LKT2    = -3.483585E-11  WKT2     = -1.861438E-10  PKT2     = -2.338753E-16  
+AT      = 40000          UTE      = -2.111231      LUTE     = 2.069309E-07   
+WUTE    = 2.722858E-08   PUTE     = 8.424978E-15   UA1      = -1.008387E-10  
+LUA1    = 1.641422E-16   WUA1     = -1.466391E-16  PUA1     = 1.171005E-22   
+UB1     = 0              UC1      = 6.059803E-11   LUC1     = -3.702581E-17  
+WUC1    = -3.459789E-17  PUC1     = 2.110471E-23   KT1L     = 0              
+PRT     = 0              CJ       = cjn3           MJ       = 0.34976        
+PB      = 0.9065364      CJSW     = cjswn3         MJSW     = 0.1312098      
+PBSW    = 0.9065364      CJSWG    = cjgaten3       MJSWG    = 0.1312089      
+PBSWG   = 0.9065364      CTA      = 0.0008377299   CTP      = 0.0003438209   
+PTA     = 0.001899522    PTP      = 0.001899522    JS       = 2E-06          
+JSW     = 8E-11          CGDO     = cgon3          CGSO     = cgon3           
+CAPMOD  = 0              NQSMOD   = 0              XPART    = 1              
+CF      = 0              TLEV     = 1              TLEVC    = 1              
+XTI     = 3              N        = 1              HDIF     = hdifn3          
+LDIF    = 1.2E-07        RSH      = 4.5            RS       = 0              
+RD      = 0              ACM      = 12             )
*
***************************************************************
*              3.3V NOMINAL VT PMOS DEVICES MODEL             *
***************************************************************
.MODEL pch3.1           PMOS   (                    LMIN     = '1.21E-06-dxl3' 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = 2.1E-05        WMIN     = '1.2E-06-dxw3' WMAX     = 1.01E-04       
+NLEV    = 3              AF       = 1.15           KF       = 1.7E-23      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3'    
+XW      = '0+dxw3'       VERSION  = 3.1            TOX      = toxp3           
+XJ      = 1E-07          NCH      = 4.06E+17       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.5E-08        WINT     = 1.5E-08        MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '-0.8657545+dvthp3' LVTH0= -7.166991E-09  WVTH0    = 2.852648E-08   
+PVTH0   = -5.138597E-16  K1       = 0.7495604      LK1      = 2.894623E-08   
+WK1     = 4.367089E-08   PK1      = -1.027422E-13  K2       = 0.01980175     
+LK2     = -9.32359E-09   WK2      = -1.475533E-08  PK2      = 2.901203E-14   
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 220643.6       LVSAT    = -0.0128788     
+UA      = 1.309398E-09   LUA      = -3.708588E-16  WUA      = -6.448764E-17  
+PUA     = 2.259873E-22   UB       = 1.551704E-19   LUB      = 3.50211E-25    
+WUB     = -1.340158E-25  PUB      = -1.903072E-31  UC       = -8.356064E-11  
+LUC     = 4.822876E-17   WUC      = -6.26989E-18   PUC      = -3.688054E-23  
+RDSW    = 1000           PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.01133626     LU0      = -8.277736E-10  
+WU0     = 2.061367E-10   PU0      = -1.660241E-17  A0       = 0.8086746      
+LA0     = -1.074945E-07  WA0      = -4.30573E-08   PA0      = 1.365498E-13   
+KETA    = 0.02251789     LKETA    = -2.274028E-08  WKETA    = -1.112205E-09  
+PKETA   = 6.900798E-15   A1       = 0              A2       = 0.5974733      
+LA2     = 5.05588E-08    WA2      = 2.956214E-09   PA2      = -5.915379E-14  
+AGS     = 0.01           B0       = 0              B1       = 0              
+VOFF    = -0.141485      LVOFF    = 1.316212E-08   WVOFF    = 2.827821E-09   
+PVOFF   = -2.780082E-15  NFACTOR  = 1              CIT      = -0.0001521328  
+LCIT    = 8.731296E-10   WCIT     = 4.564499E-10   PCIT     = -1.019054E-15  
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = 2.544764E-05   LETA0    = 4.912922E-10   WETA0    = 1.412767E-11   
+PETA0   = -2.826944E-16  ETAB     = -0.0004451229  LETAB    = 3.104187E-10   
+WETAB   = 4.765326E-10   PETAB    = -6.481088E-16  DSUB     = 0              
+PCLM    = 1.121461       LPCLM    = 5.039607E-08   WPCLM    = -5.275114E-07  
+PPCLM   = 6.294251E-13   PDIBLC1  = 1E-05          PDIBLC2  = 0.0001         
+PDIBLCB = 0.01           DROUT    = 0              PSCBE1   = 2.045924E+08   
+LPSCBE1 = 249.5007       WPSCBE1  = 12.7466        PPSCBE1  = 1.369188E-05   
+PSCBE2  = 5E-07          PVAG     = 0              DELTA    = 0.01           
+ALPHA0  = 1.14102E-06    BETA0    = 25.84          KT1      = -0.2492986     
+LKT1    = -7.213574E-09  WKT1     = 2.676708E-08   PKT1     = -5.121476E-15  
+KT2     = -0.02753976    LKT2     = -2.720097E-09  WKT2     = 3.685891E-09   
+PKT2    = -2.427157E-15  AT       = 10000          UTE      = -0.9057691     
+LUTE    = 1.045918E-07   WUTE     = -2.061428E-08  PUTE     = 4.09825E-14    
+UA1     = 9.999999E-11   UB1      = 0              UC1      = 7.090033E-11   
+LUC1    = -1.801566E-17  WUC1     = -2.559456E-18  PUC1     = 5.121466E-23   
+KT1L    = 0              PRT      = 0              CJ       = cjp3            
+MJ      = 0.4812153      PB       = 0.9769741      CJSW     = cjswp3          
+MJSW    = 0.3237595      PBSW     = 0.9769741      CJSWG    = cjgatep3         
+MJSWG   = 0.3237595      PBSWG    = 0.9769741      CTA      = 0.0008304754   
+CTP     = 0.0002535677   PTA      = 0.001498728    PTP      = 0.001498728    
+JS      = 2E-06          JSW      = 2E-11          CGDO     = cgop3           
+CGSO    = cgop3          CAPMOD   = 0              NQSMOD   = 0              
+XPART   = 1              CF       = 0              TLEV     = 1              
+TLEVC   = 1              XTI      = 3              N        = 1              
+HDIF    = hdifp3         LDIF     = 1.2E-07        RSH      = 3.5            
+RS      = 0              RD       = 0              ACM      = 12             )


.MODEL pch3.2           PMOS   (                    LMIN     = '6.1E-07-dxl3'  
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '1.21E-06-dxl3' WMIN     = '1.2E-06-dxw3' WMAX     = 1.01E-04       
+NLEV    = 3              AF       = 1.15           KF       = 1.7E-23      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3'    
+XW      = '0+dxw3'       VERSION  = 3.1            TOX      = toxp3           
+XJ      = 1E-07          NCH      = 4.06E+17       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.5E-08        WINT     = 1.5E-08        MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '-0.8762006+dvthp3' LVTH0= 5.47275E-09    WVTH0    = 2.182472E-08   
+PVTH0   = 7.595278E-15   K1       = 0.7650834      LK1      = 1.016343E-08   
+WK1     = -6.609375E-08  PK1      = 3.0073E-14     K2       = 0.01658919     
+LK2     = -5.436386E-09  WK2      = 1.926462E-08   PK2      = -1.215211E-14  
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 220166.6       LVSAT    = -0.01230165    
+UA      = 1.31243E-09    LUA      = -3.745276E-16  WUA      = 3.476225E-16   
+PUA     = -2.726658E-22  UB       = 1.238079E-19   LUB      = 3.881596E-25   
+WUB     = -4.099551E-25  PUB      = 1.435792E-31   UC       = -8.12157E-11   
+LUC     = 4.539136E-17   WUC      = -3.672243E-17  PUC      = -3.296893E-26  
+RDSW    = 1000           PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.01152129     LU0      = -1.051659E-09  
+WU0     = 1.695357E-10   PU0      = 2.768477E-17   A0       = 0.7318224      
+LA0     = -1.450335E-08  WA0      = 7.217537E-08   PA0      = -2.881725E-15  
+KETA    = 0.01570449     LKETA    = -1.449607E-08  WKETA    = 8.576757E-09   
+PKETA   = -4.822846E-15  A1       = 0              A2       = 0.6780646      
+LA2     = -4.695658E-08  WA2      = -8.161467E-08  PA2      = 4.317698E-14   
+AGS     = 0.01           B0       = 0              B1       = 0              
+VOFF    = -0.1355404     LVOFF    = 5.96916E-09    WVOFF    = -1.262336E-08  
+PVOFF   = 1.591585E-14   NFACTOR  = 1              CIT      = 0.000459138    
+LCIT    = 1.33492E-10    WCIT     = -2.885729E-10  PCIT     = -1.175762E-16  
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = 0.0004918504   LETA0    = -7.30551E-11   WETA0    = -4.236093E-10  
+PETA0   = 2.469673E-16   ETAB     = -6.80476E-05   LETAB    = -1.458424E-10  
+WETAB   = -1.803361E-10  PETAB    = 1.467024E-16   DSUB     = 0              
+PCLM    = 1.08611        LPCLM    = 9.31703E-08    WPCLM    = -2.403183E-08  
+PPCLM   = 2.021474E-14   PDIBLC1  = 1E-05          PDIBLC2  = 0.0001         
+PDIBLCB = 0.01           DROUT    = 0              PSCBE1   = 3.542486E+08   
+LPSCBE1 = 68.41665       WPSCBE1  = 45.17923       PPSCBE1  = -2.555162E-05  
+PSCBE2  = 5E-07          PVAG     = 0              DELTA    = 0.01           
+ALPHA0  = 1.14102E-06    BETA0    = 25.84          KT1      = -0.2427252     
+LKT1    = -1.51674E-08   WKT1     = 9.057951E-09   PKT1     = 1.630657E-14   
+KT2     = -0.03114964    LKT2     = 1.647854E-09   WKT2     = 3.566021E-10   
+PKT2    = 1.601282E-15   AT       = 10000          UTE      = -0.8684992     
+LUTE    = 5.949524E-08   WUTE     = 3.721301E-08   PUTE     = -2.89885E-14   
+UA1     = 9.999999E-11   UB1      = 0              UC1      = 8.515966E-11   
+LUC1    = -3.526944E-17  WUC1     = 5.324321E-17   PUC1     = -1.630656E-23  
+KT1L    = 0              PRT      = 0              CJ       = cjp3            
+MJ      = 0.4812153      PB       = 0.9769741      CJSW     = cjswp3          
+MJSW    = 0.3237595      PBSW     = 0.9769741      CJSWG    = cjgatep3         
+MJSWG   = 0.3237595      PBSWG    = 0.9769741      CTA      = 0.0008304754   
+CTP     = 0.0002535677   PTA      = 0.001498728    PTP      = 0.001498728    
+JS      = 2E-06          JSW      = 2E-11          CGDO     = cgop3           
+CGSO    = cgop3          CAPMOD   = 0              NQSMOD   = 0              
+XPART   = 1              CF       = 0              TLEV     = 1              
+TLEVC   = 1              XTI      = 3              N        = 1              
+HDIF    = hdifp3         LDIF     = 1.2E-07        RSH      = 3.5            
+RS      = 0              RD       = 0              ACM      = 12             )


.MODEL pch3.3           PMOS   (                    LMIN     = 3E-07          
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '6.1E-07-dxl3' WMIN     = '1.2E-06-dxw3' WMAX     = 1.01E-04       
+NLEV    = 3              AF       = 1.15           KF       = 1.7E-23      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3'    
+XW      = '0+dxw3'       VERSION  = 3.1            TOX      = toxp3           
+XJ      = 1E-07          NCH      = 4.06E+17       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.5E-08        WINT     = 1.5E-08        MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    ='-0.8993466+dvthp3' LVTH0= 1.959182E-08   WVTH0    = 3.852533E-08   
+PVTH0   = -2.592092E-15  K1       = 0.787711       LK1      = -3.639442E-09  
+WK1     = -6.066998E-08  PK1      = 2.67645E-14    K2       = 0.0360656      
+LK2     = -1.7317E-08    WK2      = 7.692424E-10   PK2      = -8.699363E-16  
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 207701.7       LVSAT    = -0.004698031   
+WVSAT   = -0.009010976   PVSAT    = 5.496696E-09   UA       = 1.380718E-09   
+LUA     = -4.161832E-16  WUA      = -1.25416E-16   PUA      = 1.588758E-23   
+UB      = 1.546128E-19   LUB      = 3.693687E-25   WUB      = -3.433292E-25  
+PUB     = 1.029375E-31   UC       = -4.428216E-11  LUC      = 2.286191E-17   
+WUC     = -7.157988E-17  PUC      = 2.123008E-23   RDSW     = 1000           
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.01042639     LU0      = -3.837689E-10  WU0      = 1.333488E-10   
+PU0     = 4.975878E-17   A0       = 0.5522249      LA0      = 9.505108E-08   
+WA0     = 1.373286E-07   PA0      = -4.262518E-14  KETA     = -0.01347102    
+LKETA   = 3.300994E-09   WKETA    = 7.643725E-09   PKETA    = -4.253697E-15  
+A1      = 0              A2       = 0.5926555      LA2      = 5.142968E-09   
+WA2     = -1.383959E-08  PA2      = 1.834182E-15   AGS      = 0.02983485     
+LAGS    = -1.209926E-08  WAGS     = 8.293222E-09   PAGS     = -5.058866E-15  
+B0      = 0              B1       = 0              VOFF     = -0.1332301     
+LVOFF   = 4.55989E-09    WVOFF    = 7.664835E-09   PVOFF    = 3.540047E-15   
+NFACTOR = 1              CIT      = 0.0009847683   LCIT     = -1.871425E-10  
+WCIT    = -1.224069E-09  PCIT     = 4.530766E-16   CDSC     = 0              
+CDSCB   = 0              CDSCD    = 0              ETA0     = -0.001316437   
+LETA0   = 1.03E-09       WETA0    = -1.298885E-10  PETA0    = 6.779773E-17   
+ETAB    = 0.001374562    LETAB    = -1.025835E-09  WETAB    = -5.61042E-10   
+PETAB   = 3.789329E-16   DSUB     = 0              PCLM     = 0.8455005      
+LPCLM   = 2.399422E-07   WPCLM    = 2.14982E-07    PPCLM    = -1.255837E-13  
+PDIBLC1 = 1E-05          PDIBLC2  = 0.0001         PDIBLCB  = 0.01           
+DROUT   = 0              PSCBE1   = 4.333794E+08   LPSCBE1  = 20.14691       
+WPSCBE1 = 62.92567       PPSCBE1  = -3.637695E-05  PSCBE2   = 5E-07          
+PVAG    = 0              DELTA    = 0.01           ALPHA0   = 1.14102E-06    
+BETA0   = 25.84          KT1      = -0.2631533     LKT1     = -2.706274E-09  
+WKT1    = 6.367427E-08   PKT1     = -1.700939E-14  KT2      = -0.02769157    
+LKT2    = -4.615678E-10  WKT2     = 4.20315E-09    PKT2     = -7.451122E-16  
+AT      = 10000          UTE      = -0.8112272     LUTE     = 2.455935E-08   
+WUTE    = -4.160259E-08  PUTE     = 1.908901E-14   UA1      = 9.999999E-11   
+UB1     = 0              UC1      = 4.359622E-11   LUC1     = -9.915737E-18  
+WUC1    = 7.049242E-17   PUC1     = -2.682859E-23  KT1L     = 0              
+PRT     = 0              CJ       = cjp3           MJ       = 0.4812153      
+PB      = 0.9769741      CJSW     = cjswp3         MJSW     = 0.3237595      
+PBSW    = 0.9769741      CJSWG    = cjgatep3       MJSWG    = 0.3237595      
+PBSWG   = 0.9769741      CTA      = 0.0008304754   CTP      = 0.0002535677   
+PTA     = 0.001498728    PTP      = 0.001498728    JS       = 2E-06          
+JSW     = 2E-11          CGDO     = cgop3          CGSO     = cgop3           
+CAPMOD  = 0              NQSMOD   = 0              XPART    = 1              
+CF      = 0              TLEV     = 1              TLEVC    = 1              
+XTI     = 3              N        = 1              HDIF     = hdifp3          
+LDIF    = 1.2E-07        RSH      = 3.5            RS       = 0              
+RD      = 0              ACM      = 12             )


.MODEL pch3.4           PMOS   (                    LMIN     = '1.21E-06-dxl3' 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = 2.1E-05        WMIN     = '6E-07-dxw3'   WMAX     = '1.2E-06-dxw3'  
+NLEV    = 3              AF       = 1.15           KF       = 1.7E-23      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3'    
+XW      = '0+dxw3'       VERSION  = 3.1            TOX      = toxp3           
+XJ      = 1E-07          NCH      = 4.06E+17       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.5E-08        WINT     = 1.5E-08        MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    ='-0.8697616+dvthp3' LVTH0= -4.262343E-09  WVTH0    = 3.321487E-08   
+PVTH0   = -3.912298E-15  K1       = 0.8643348      LK1      = -1.415842E-07  
+WK1     = -9.061522E-08  PK1      = 9.677838E-14   K2       = -0.0149491     
+LK2     = 4.454492E-08   WK2      = 2.590317E-08   PK2      = -3.401413E-14  
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 220643.6       LVSAT    = -0.0128788     
+UA      = 1.472633E-09   LUA      = -2.079463E-16  WUA      = -2.554725E-16  
+PUA     = 3.537958E-23   UB       = 3.47797E-20    LUB      = 3.045587E-25   
+WUB     = 6.841254E-27   PUB      = -1.368939E-31  UC       = -8.682838E-11  
+LUC     = 2.642634E-17   WUC      = -2.446639E-18  PUC      = -1.137172E-23  
+RDSW    = 1000           PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.01138442     LU0      = -5.03719E-10   
+WU0     = 1.497905E-10   PU0      = -3.957462E-16  A0       = 0.6824934      
+LA0     = 8.380321E-08   WA0      = 1.045747E-07   PA0      = -8.726858E-14  
+KETA    = 0.0187825      LKETA    = -1.171542E-08  WKETA    = 3.258193E-09   
+PKETA   = -5.998288E-15  A1       = 0              A2       = 0.6            
+AGS     = 0.01           B0       = 0              B1       = 0              
+VOFF    = -0.1388419     LVOFF    = 1.722616E-08   WVOFF    = -2.645448E-10  
+PVOFF   = -7.535011E-15  NFACTOR  = 1              CIT      = 6.086276E-05   
+LCIT    = 4.889814E-10   WCIT     = 2.072451E-10   PCIT     = -5.696004E-16  
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = 2.566907E-05   LETA0    = 4.868626E-10   WETA0    = 1.386863E-11   
+PETA0   = -2.775117E-16  ETAB     = -2.626865E-05  LETAB    = -4.748648E-10  
+WETAB   = -1.352686E-11  PETAB    = 2.706729E-16   DSUB     = 0              
+PCLM    = 0.676149       LPCLM    = 4.772579E-07   WPCLM    = -6.496564E-09  
+PPCLM   = 1.299967E-13   PDIBLC1  = 1E-05          PDIBLC2  = 0.0001         
+PDIBLCB = 0.01           DROUT    = 0              PSCBE1   = 1.919248E+08   
+LPSCBE1 = 324.2335       WPSCBE1  = 27.56764       PPSCBE1  = -7.374548E-05  
+PSCBE2  = 5E-07          PVAG     = 0              DELTA    = 0.01           
+ALPHA0  = 1.14102E-06    BETA0    = 25.84          KT1      = -0.2262373     
+LKT1    = -1.526136E-08  WKT1     = -2.146146E-10  PKT1     = 4.294437E-15   
+KT2     = -0.02377676    LKT2     = -6.997268E-09  WKT2     = -7.168213E-10  
+PKT2    = 2.577133E-15   AT       = 10000          UTE      = -0.9084394     
+LUTE    = 1.378851E-07   WUTE     = -1.749001E-08  PUTE     = 2.029399E-15   
+UA1     = 9.999999E-11   UB1      = 0              UC1      = 6.626702E-11   
+LUC1    = 7.46969E-17    WUC1     = 2.861518E-18   PUC1     = -5.725904E-23  
+KT1L    = 0              PRT      = 0              CJ       = cjp3            
+MJ      = 0.4812153      PB       = 0.9769741      CJSW     = cjswp3          
+MJSW    = 0.3237595      PBSW     = 0.9769741      CJSWG    = cjgatep3         
+MJSWG   = 0.3237595      PBSWG    = 0.9769741      CTA      = 0.0008304754   
+CTP     = 0.0002535677   PTA      = 0.001498728    PTP      = 0.001498728    
+JS      = 2E-06          JSW      = 2E-11          CGDO     = cgop3           
+CGSO    = cgop3          CAPMOD   = 0              NQSMOD   = 0              
+XPART   = 1              CF       = 0              TLEV     = 1              
+TLEVC   = 1              XTI      = 3              N        = 1              
+HDIF    = hdifp3         LDIF     = 1.2E-07        RSH      = 3.5            
+RS      = 0              RD       = 0              ACM      = 12             )


.MODEL pch3.5           PMOS   (                    LMIN     = '6.1E-07-dxl3'  
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '1.21E-06-dxl3' WMIN     = '6E-07-dxw3'   WMAX     = '1.2E-06-dxw3'  
+NLEV    = 3              AF       = 1.15           KF       = 1.7E-23      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3'    
+XW      = '0+dxw3'       VERSION  = 3.1            TOX      = toxp3           
+XJ      = 1E-07          NCH      = 4.06E+17       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.5E-08        WINT     = 1.5E-08        MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '-0.89044+dvthp3'  LVTH0= 2.075841E-08   WVTH0    = 3.848483E-08   
+PVTH0   = -1.028895E-14  K1       = 0.7137034      LK1      = 4.067983E-08   
+WK1     = -5.979207E-09  PK1      = -5.63119E-15   K2       = 0.03903553     
+LK2     = -2.077648E-08  WK2      = -6.997599E-09  PK2      = 5.795793E-15   
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 220166.6       LVSAT    = -0.01230165    
+UA      = 2.188859E-09   LUA      = -1.07458E-15   WUA      = -6.778E-16     
+PUA     = 5.463957E-22   UB       = -4.409997E-19  LUB      = 8.802516E-25   
+WUB     = 2.508699E-25   PUB      = -4.321685E-31  UC       = -1.316403E-10  
+LUC     = 8.064878E-17   WUC      = 2.227439E-17   PUC      = -4.128415E-23  
+RDSW    = 1000           PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.01225401     LU0      = -1.555926E-09  
+WU0     = -6.877496E-10  PU0      = 6.176772E-16   A0       = 0.8212562      
+LA0     = -8.409972E-08  WA0      = -3.246216E-08  PA0      = 7.854604E-14   
+KETA    = 0.03195265     LKETA    = -2.76513E-08   WKETA    = -1.04336E-08   
+PKETA   = 1.056878E-14   A1       = 0              A2       = 0.6162015      
+LA2     = -1.960371E-08  WA2      = -9.234808E-09  PA2      = 1.117412E-14   
+AGS     = 0.01           B0       = 0              B1       = 0              
+VOFF    = -0.1354985     LVOFF    = 1.318059E-08   WVOFF    = -1.267238E-08  
+PVOFF   = 7.478473E-15   NFACTOR  = 1              CIT      = 0.0005371643   
+LCIT    = -8.734356E-11  WCIT     = -3.798637E-10  PCIT     = 1.408014E-16   
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = 0.0005102879   LETA0    = -9.95263E-11   WETA0    = -4.451811E-10  
+PETA0   = 2.779386E-16   ETAB     = -0.0006385153  LETAB    = 2.659537E-10   
+WETAB   = 4.871111E-10   PETAB    = -3.35099E-16   DSUB     = 0              
+PCLM    = 1.222547       LPCLM    = -1.838844E-07  WPCLM    = -1.836635E-07  
+PPCLM   = 3.443687E-13   PDIBLC1  = 1E-05          PDIBLC2  = 0.0001         
+PDIBLCB = 0.01           DROUT    = 0              PSCBE1   = 4.333364E+08   
+LPSCBE1 = 32.12551       WPSCBE1  = -47.35342      PPSCBE1  = 1.6909E-05     
+PSCBE2  = 5E-07          PVAG     = 0              DELTA    = 0.01           
+ALPHA0  = 1.14102E-06    BETA0    = 25.84          KT1      = -0.2484575     
+LKT1    = 1.162508E-08   WKT1     = 1.576479E-08   PKT1     = -1.504064E-14  
+KT2     = -0.03029261    LKT2     = 8.869179E-10   WKT2     = -6.461149E-10  
+PKT2    = 2.491577E-15   AT       = 10000          UTE      = -0.8090945     
+LUTE    = 1.767774E-08   WUTE     = -3.229048E-08  PUTE     = 1.993797E-14   
+UA1     = 9.999999E-11   UB1      = 0              UC1      = 2.266167E-10   
+LUC1    = -1.193262E-16  WUC1     = -1.122615E-16  PUC1     = 8.203982E-23   
+KT1L    = 0              PRT      = 0              CJ       = cjp3            
+MJ      = 0.4812153      PB       = 0.9769741      CJSW     = cjswp3          
+MJSW    = 0.3237595      PBSW     = 0.9769741      CJSWG    = cjgatep3        
+MJSWG   = 0.3237595      PBSWG    = 0.9769741      CTA      = 0.0008304754   
+CTP     = 0.0002535677   PTA      = 0.001498728    PTP      = 0.001498728    
+JS      = 2E-06          JSW      = 2E-11          CGDO     = cgop3           
+CGSO    = cgop3          CAPMOD   = 0              NQSMOD   = 0              
+XPART   = 1              CF       = 0              TLEV     = 1              
+TLEVC   = 1              XTI      = 3              N        = 1              
+HDIF    = hdifp3         LDIF     = 1.2E-07        RSH      = 3.5            
+RS      = 0              RD       = 0              ACM      = 12             )


.MODEL pch3.6           PMOS   (                    LMIN     = 3E-07          
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '6.1E-07-dxl3' WMIN     = '6E-07-dxw3'   WMAX     = '1.2E-06-dxw3'  
+NLEV    = 3              AF       = 1.15           KF       = 1.7E-23      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3'    
+XW      = '0+dxw3'       VERSION  = 3.1            TOX      = toxp3           
+XJ      = 1E-07          NCH      = 4.06E+17       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.5E-08        WINT     = 1.5E-08        MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    ='-0.8887095+dvthp3' LVTH0= 1.970285E-08   WVTH0    = 2.607999E-08   
+PVTH0   = -2.722E-15     K1       = 0.7752625      LK1      = 3.12877E-09    
+WK1     = -4.610524E-08  PK1      = 1.884569E-14   K2       = 0.02663469     
+LK2     = -1.321197E-08  WK2      = 1.180342E-08   PK2      = -5.672828E-15  
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 200000         UA       = 1.289613E-09   
+LUA     = -5.260399E-16  WUA      = -1.882345E-17  PUA      = 1.4442E-22     
+UB      = 1.099887E-19   LUB      = 5.441487E-25   WUB      = -2.911191E-25  
+PUB     = -1.015552E-31  UC       = -6.319155E-11  LUC      = 3.889503E-17   
+WUC     = -4.94559E-17   PUC      = 2.471324E-24   RDSW     = 1000           
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.01080293     LU0      = -6.707633E-10  WU0      = -3.072005E-10  
+PU0     = 3.855422E-16   A0       = 0.5411521      LA0      = 8.676373E-08   
+WA0     = 1.502838E-07   PA0      = -3.292899E-14  KETA     = -0.01391247    
+LKETA   = 3.264228E-10   WKETA    = 8.160215E-09   PKETA    = -7.734491E-16  
+A1      = 0              A2       = 0.5626122      LA2      = 1.308576E-08   
+WA2     = 2.131109E-08   PA2      = -7.458882E-15  AGS      = 0.03692307     
+LAGS    = -1.642307E-08  B0       = 0              B1       = 0              
+VOFF    = -0.1104863     LVOFF    = -2.076811E-09  WVOFF    = -1.894536E-08  
+PVOFF   = 1.130499E-14   NFACTOR  = 1              CIT      = 0.0001821631   
+LCIT    = 1.292072E-10   WCIT     = -2.850211E-10  PCIT     = 8.294742E-17   
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = -0.001689153   LETA0    = 1.242133E-09   WETA0    = 3.06189E-10    
+PETA0   = -1.803973E-16  ETAB     = 0.0002886751   LETAB    = -2.996325E-10  
+WETAB   = 7.094466E-10   PETAB    = -4.707237E-16  DSUB     = 0              
+PCLM    = 0.4858621      LPCLM    = 2.654938E-07   WPCLM    = 6.35759E-07    
+PPCLM   = -1.55479E-13   PDIBLC1  = 1E-05          PDIBLC2  = 0.0001         
+PDIBLCB = 0.01           DROUT    = 0              PSCBE1   = 5.560217E+08   
+LPSCBE1 = -42.71251      WPSCBE1  = -80.56585      PPSCBE1  = 3.716857E-05   
+PSCBE2  = 5E-07          PVAG     = 0              DELTA    = 0.01           
+ALPHA0  = 1.14102E-06    BETA0    = 25.84          KT1      = -0.2139193     
+LKT1    = -9.443249E-09  WKT1     = 6.070508E-09   PKT1     = -9.127131E-15  
+KT2     = -0.0231653     LKT2     = -3.460741E-09  WKT2     = -1.092581E-09  
+PKT2    = 2.763921E-15   AT       = 10000          UTE      = -0.8629226     
+LUTE    = 5.05129E-08    WUTE     = 1.888103E-08   PUTE     = -1.127665E-14  
+UA1     = 9.999999E-11   UB1      = 0              UC1      = 5.926922E-11   
+LUC1    = -1.724423E-17  WUC1     = 5.2155E-17     PUC1     = -1.825425E-23  
+KT1L    = 0              PRT      = 0              CJ       = cjp3            
+MJ      = 0.4812153      PB       = 0.9769741      CJSW     = cjswp3          
+MJSW    = 0.3237595      PBSW     = 0.9769741      CJSWG    = cjgatep3        
+MJSWG   = 0.3237595      PBSWG    = 0.9769741      CTA      = 0.0008304754   
+CTP     = 0.0002535677   PTA      = 0.001498728    PTP      = 0.001498728    
+JS      = 2E-06          JSW      = 2E-11          CGDO     = cgop3           
+CGSO    = cgop3          CAPMOD   = 0              NQSMOD   = 0              
+XPART   = 1              CF       = 0              TLEV     = 1              
+TLEVC   = 1              XTI      = 3              N        = 1              
+HDIF    = hdifp3         LDIF     = 1.2E-07        RSH      = 3.5            
+RS      = 0              RD       = 0              ACM      = 12             )


.MODEL pch3.7           PMOS   (                    LMIN     = '1.21E-06-dxl3' 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = 2.1E-05        WMIN     = 3E-07          WMAX     = '6E-07-dxw3'    
+NLEV    = 3              AF       = 1.15           KF       = 1.7E-23      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3'    
+XW      = '0+dxw3'       VERSION  = 3.1            TOX      = toxp3           
+XJ      = 1E-07          NCH      = 4.06E+17       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.5E-08        WINT     = 1.5E-08        MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '-0.845781+dvthp3' LVTH0= -2.344025E-08  WVTH0    = 1.954592E-08   
+PVTH0   = 7.019112E-15   K1       = 0.7228484      LK1      = 3.825013E-08   
+WK1     = -9.967933E-09  PK1      = -5.727183E-15  K2       = 0.0315284      
+LK2     = -2.425206E-08  WK2      = -5.890092E-10  PK2      = 5.200146E-15   
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 220643.6       LVSAT    = -0.0128788     
+UA      = 1.308071E-09   LUA      = -1.242251E-16  WUA      = -1.616725E-16  
+PUA     = -1.234149E-23  UB       = 4.388564E-20   LUB      = 1.223484E-25   
+WUB     = 1.650879E-27   PUB      = -3.303407E-32  UC       = -9.2055E-11    
+LUC     = 3.657374E-17   WUC      = 5.325276E-19   PUC      = -1.715573E-23  
+RDSW    = 1000           PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.01132015     LU0      = -4.777295E-10  
+WU0     = 1.864217E-10   PU0      = -4.105603E-16  A0       = 0.8102126      
+LA0     = -9.208829E-08  WA0      = 3.177474E-08   PA0      = 1.298958E-14   
+KETA    = 0.02356912     LKETA    = -1.614458E-08  WKETA    = 5.298219E-10   
+PKETA   = -3.473666E-15  A1       = 0              A2       = 0.6            
+AGS     = 0.01           B0       = 0              B1       = 0              
+VOFF    = -0.1398725     LVOFF    = -1.633148E-08  WVOFF    = 3.228569E-10   
+PVOFF   = 1.159284E-14   NFACTOR  = 1              CIT      = 0.000293833    
+LCIT    = -2.404289E-10  WCIT     = 7.445208E-11   PCIT     = -1.538365E-16  
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = 5E-05          ETAB     = -5E-05         DSUB     = 0              
+PCLM    = 0.6504055      LPCLM    = 9.923854E-07   WPCLM    = 8.177225E-09   
+PPCLM   = -1.636259E-13  PDIBLC1  = 1E-05          PDIBLC2  = 0.0001         
+PDIBLCB = 0.01           DROUT    = 0              PSCBE1   = 2.881344E+08   
+LPSCBE1 = 138.4074       WPSCBE1  = -27.27183      PPSCBE1  = 3.217539E-05   
+PSCBE2  = 5E-07          PVAG     = 0              DELTA    = 0.01           
+ALPHA0  = 1.14102E-06    BETA0    = 25.84          KT1      = -0.2340767     
+LKT1    = -2.047725E-08  WKT1     = 4.253809E-09   PKT1     = 7.267489E-15   
+KT2     = -0.02923623    LKT2     = -3.118998E-09  WKT2     = 2.395076E-09   
+PKT2    = 3.665189E-16   AT       = 10000          UTE      = -0.8964766     
+LUTE    = 9.085518E-08   WUTE     = -2.430877E-08  PUTE     = 2.883644E-14   
+UA1     = 9.999999E-11   UB1      = 0              UC1      = 7.244574E-11   
+LUC1    = -4.893935E-17  WUC1     = -6.603512E-19  PUC1     = 1.321362E-23   
+KT1L    = 0              PRT      = 0              CJ       = cjp3            
+MJ      = 0.4812153      PB       = 0.9769741      CJSW     = cjswp3          
+MJSW    = 0.3237595      PBSW     = 0.9769741      CJSWG    = cjgatep3         
+MJSWG   = 0.3237595      PBSWG    = 0.9769741      CTA      = 0.0008304754   
+CTP     = 0.0002535677   PTA      = 0.001498728    PTP      = 0.001498728    
+JS      = 2E-06          JSW      = 2E-11          CGDO     = cgop3           
+CGSO    = cgop3          CAPMOD   = 0              NQSMOD   = 0              
+XPART   = 1              CF       = 0              TLEV     = 1              
+TLEVC   = 1              XTI      = 3              N        = 1              
+HDIF    = hdifp3         LDIF     = 1.2E-07        RSH      = 3.5            
+RS      = 0              RD       = 0              ACM      = 12             )


.MODEL pch3.8           PMOS   (                    LMIN     = '6.1E-07-dxl3'  
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '1.21E-06-dxl3' WMIN     = 3E-07          WMAX     = '6E-07-dxw3'    
+NLEV    = 3              AF       = 1.15           KF       = 1.7E-23      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3'    
+XW      = '0+dxw3'       VERSION  = 3.1            TOX      = toxp3           
+XJ      = 1E-07          NCH      = 4.06E+17       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.5E-08        WINT     = 1.5E-08        MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    ='-0.8582775+dvthp3' LVTH0= -8.319584E-09  WVTH0    = 2.01522E-08    
+PVTH0   = 6.285509E-15   K1       = 0.7181219      LK1      = 4.396911E-08   
+WK1     = -8.497773E-09  PK1      = -7.506078E-15  K2       = 0.01673988     
+LK2     = -6.357945E-09  WK2      = 5.710922E-09   PK2      = -2.422771E-15  
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 220166.6       LVSAT    = -0.01230165    
+UA      = 1.239495E-09   LUA      = -4.124718E-17  WUA      = -1.36662E-16   
+PUA     = -4.260415E-23  UB       = -9.166205E-22  LUB      = 1.765591E-25   
+WUB     = 2.249021E-29   PUB      = -3.106371E-32  UC       = -7.106184E-11  
+LUC     = 1.117204E-17   WUC      = -1.225535E-17  PUC      = -1.682403E-24  
+RDSW    = 1000           PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.01106304     LU0      = -1.666174E-10  
+WU0     = -8.89349E-12   PU0      = -1.74229E-16   A0       = 0.729593       
+LA0     = 5.461449E-09   WA0      = 1.978582E-08   PA0      = 2.749617E-14   
+KETA    = 0.01541945     LKETA    = -6.283478E-09  WKETA    = -1.009668E-09  
+PKETA   = -1.610884E-15  A1       = 0              A2       = 0.6            
+AGS     = -0.008299994   LAGS     = 2.214299E-08   WAGS     = 1.0431E-08     
+PAGS    = -1.262151E-14  B0       = 0              B1       = 0              
+VOFF    = -0.1976165     LVOFF    = 5.353881E-08   WVOFF    = 2.273489E-08   
+PVOFF   = -1.552572E-14  NFACTOR  = 1              CIT      = -0.0001475861  
+LCIT    = 2.936882E-10   WCIT     = 1.044404E-11   PCIT     = -7.638673E-17  
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = -0.0003452548  LETA0    = 4.782583E-10   WETA0    = 4.247823E-11   
+PETA0   = -5.139866E-17  ETAB     = 0.0002584272   LETAB    = -3.731969E-10  
+WETAB   = -2.414614E-11  PETAB    = 2.921683E-17   DSUB     = 0              
+PCLM    = 1.268129       LPCLM    = 2.449404E-07   WPCLM    = -2.096447E-07  
+PPCLM   = 9.993861E-14   PDIBLC1  = 1E-05          PDIBLC2  = 0.0001         
+PDIBLCB = 0.01           DROUT    = 0              PSCBE1   = 3.134549E+08   
+LPSCBE1 = 107.7696       WPSCBE1  = 20.97902       PPSCBE1  = -2.620813E-05  
+PSCBE2  = 5E-07          PVAG     = 0              DELTA    = 0.01           
+ALPHA0  = 1.14102E-06    BETA0    = 25.84          KT1      = -0.2708249     
+LKT1    = 2.39882E-08    WKT1     = 2.851423E-08   PKT1     = -2.208763E-14  
+KT2     = -0.04530036    LKT2     = 1.63186E-08    WKT2     = 7.908302E-09   
+PKT2    = -6.304484E-15  AT       = 10000          UTE      = -0.8901234     
+LUTE    = 8.316777E-08   WUTE     = 1.389601E-08   PUTE     = -1.739134E-14  
+UA1     = 9.999999E-11   UB1      = 0              UC1      = -1.578332E-11  
+LUC1    = 5.781782E-17   WUC1     = 2.59065E-17    PUC1     = -1.893226E-23  
+KT1L    = 0              PRT      = 0              CJ       = cjp3            
+MJ      = 0.4812153      PB       = 0.9769741      CJSW     = cjswp3          
+MJSW    = 0.3237595      PBSW     = 0.9769741      CJSWG    = cjgatep3         
+MJSWG   = 0.3237595      PBSWG    = 0.9769741      CTA      = 0.0008304754   
+CTP     = 0.0002535677   PTA      = 0.001498728    PTP      = 0.001498728    
+JS      = 2E-06          JSW      = 2E-11          CGDO     = cgop3           
+CGSO    = cgop3          CAPMOD   = 0              NQSMOD   = 0              
+XPART   = 1              CF       = 0              TLEV     = 1              
+TLEVC   = 1              XTI      = 3              N        = 1              
+HDIF    = hdifp3         LDIF     = 1.2E-07        RSH      = 3.5            
+RS      = 0              RD       = 0              ACM      = 12             )


.MODEL pch3.9           PMOS   (                    LMIN     = 3E-07          
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '6.1E-07-dxl3' WMIN     = 3E-07          WMAX     = '6E-07-dxw3'    
+NLEV    = 3              AF       = 1.15           KF       = 1.7E-23      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3'    
+XW      = '0+dxw3'       VERSION  = 3.1            TOX      = toxp3           
+XJ      = 1E-07          NCH      = 4.06E+17       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.5E-08        WINT     = 1.5E-08        MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    ='-0.8997636+dvthp3' LVTH0= 1.698698E-08   WVTH0    = 3.238082E-08   
+PVTH0   = -1.173951E-15  K1       = 0.6846357      LK1      = 6.439574E-08   
+WK1     = 5.552071E-09   PK1      = -1.607649E-14  K2       = 0.06403671     
+LK2     = -3.520902E-08  WK2      = -9.515737E-09  PK2      = 6.865491E-15   
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 200000         UA       = 2.053822E-09   
+LUA     = -5.37987E-16   WUA      = -4.544226E-16  PUA      = 1.512298E-22   
+UB      = -7.564845E-19  LUB      = 6.374556E-25   WUB      = 2.027707E-25   
+PUB     = -1.547401E-31  UC       = -1.498085E-10  LUC      = 5.920752E-17   
+WUC     = -8.422138E-20  PUC      = -9.106793E-24  RDSW     = 1000           
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.01327387     LU0      = -1.515228E-09  WU0      = -1.715641E-09  
+PU0     = 8.668875E-16   A0       = 0.8043622      LA0      = -4.014776E-08  
+WA0     = 2.540123E-10   PA0      = 3.941058E-14   KETA     = 0.02492782     
+LKETA   = -1.208359E-08  WKETA    = -1.397875E-08  PKETA    = 6.300259E-15   
+A1      = 0              A2       = 0.6            AGS      = 0.07915382     
+LAGS    = -3.120384E-08  WAGS     = -2.407153E-08  PAGS     = 8.425036E-15   
+B0      = 0              B1       = 0              VOFF     = -0.1412519     
+LVOFF   = 1.915642E-08   WVOFF    = -1.408983E-09  PVOFF    = -7.979533E-16  
+NFACTOR = 1              CIT      = 0.0001708427   LCIT     = 9.944662E-11   
+WCIT    = -2.785686E-10  PCIT     = 9.991098E-17   CDSC     = 0              
+CDSCB   = 0              CDSCD    = 0              ETA0     = -0.001334649   
+LETA0   = 1.081789E-09   WETA0    = 1.04122E-10    PETA0    = -8.900138E-17  
+ETAB    = 0.001816376    LETAB    = -1.323546E-09  WETAB    = -1.613434E-10  
+PETAB   = 1.129072E-16   DSUB     = 0              PCLM     = 1.692334       
+LPCLM   = -1.382515E-08  WPCLM    = -5.193025E-08  PPCLM    = 3.73279E-15    
+PDIBLC1 = 1E-05          PDIBLC2  = 0.0001         PDIBLCB  = 1.209422       
+LPDIBLCB= -7.316477E-07  WPDIBLCB = -6.836709E-07  PPDIBLCB = 4.170393E-13   
+DROUT   = 0              PSCBE1   = 5.185564E+08   LPSCBE1  = -17.34233      
+WPSCBE1 = -59.21066      PPSCBE1  = 2.270758E-05   PSCBE2   = 5E-07          
+PVAG    = 0              DELTA    = 0.01           ALPHA0   = 1.14102E-06    
+BETA0   = 25.84          KT1      = -0.1776539     LKT1     = -3.284613E-08  
+WKT1    = -1.460075E-08  PKT1     = 4.212514E-15   KT2      = -0.01942027    
+LKT2    = 5.317462E-10   WKT2     = -3.227251E-09  PKT2     = 4.882031E-16   
+AT      = 10000          UTE      = -0.8411251     LUTE     = 5.327878E-08   
+WUTE    = 6.456422E-09   PUTE     = -1.28532E-14   UA1      = 9.999999E-11   
+UB1     = 0              UC1      = 2.203461E-10   LUC1     = -8.622112E-17  
+WUC1    = -3.965883E-17  PUC1     = 2.106259E-23   KT1L     = 0              
+PRT     = 0              CJ       = cjp3           MJ       = 0.4812153      
+PB      = 0.9769741      CJSW     = cjswp3         MJSW     = 0.3237595      
+PBSW    = 0.9769741      CJSWG    = cjgatep3       MJSWG    = 0.3237595      
+PBSWG   = 0.9769741      CTA      = 0.0008304754   CTP      = 0.0002535677   
+PTA     = 0.001498728    PTP      = 0.001498728    JS       = 2E-06          
+JSW     = 2E-11          CGDO     = cgop3          CGSO     = cgop3           
+CAPMOD  = 0              NQSMOD   = 0              XPART    = 1              
+CF      = 0              TLEV     = 1              TLEVC    = 1              
+XTI     = 3              N        = 1              HDIF     = hdifp3          
+LDIF    = 1.2E-07        RSH      = 3.5            RS       = 0              
+RD      = 0              ACM      = 12             )
*
.ENDL MOS_3V
*
***************************************************************
*                                                             *
*              3.3V SYMMETRY VT DEVICES MODEL                 *
*                                                             *
***************************************************************
*
.LIB MOS_3VS
*
***************************************************************
*                                                             *
*             3.3V SYMMETRY VT PMOS DEVICES MODEL             *
*                                                             *
***************************************************************
*
.MODEL spch3.1          PMOS   (                    LMIN     = '1.21E-06-dxl3s' 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = 2.1E-05        WMIN     = '1.2E-06-dxw3s' WMAX     = 1.01E-4         
+NLEV    = 3              AF       = 1.3            KF       = 3E-23      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3s'    
+XW      = '0+dxw3s'      VERSION  = 3.1            TOX      = toxp3s           
+XJ      = 1E-07          NCH      = 2.0504E+17     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.675E-08      WINT     = 1.14E-08       MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    ='-0.5547889+dvthp3s' LVTH0= 1.266732E-09   WVTH0    = 1.720876E-08   
+PVTH0   = 1.713927E-16   K1       = 0.606287       LK1      = -3.701234E-11  
+WK1     = -1.039464E-10  PK1      = 1.083964E-14   K2       = -1.73E-08      
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 109000         UA       = 1.822E-10      
+LUA     = 1.886934E-16   WUA      = 1.428839E-15   PUA      = -1.523746E-21  
+UB      = 1.155086E-18   LUB      = 1.430493E-25   WUB      = -1.421152E-24  
+PUB     = 1.059705E-30   UC       = -5.109507E-11  LUC      = 6.761487E-17   
+WUC     = -2.878761E-17  PUC      = -4.287452E-23  RDSW     = 1211.666       
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.00967223     LU0      = 5.915674E-10   WU0      = 3.148378E-09   
+PU0     = -3.464444E-15  A0       = 1.110997       LA0      = -5.582402E-07  
+WA0     = -1.115102E-08  PA0      = 2.232261E-13   KETA     = -0.004993258   
+LKETA   = -6.133497E-09  WKETA    = 7.80913E-09    PKETA    = -2.053271E-14  
+A1      = 0              A2       = 0.8020018      LA2      = -3.71356E-11   
+PA2     = 4.371604E-17   AGS      = 0.1633515      LAGS     = 2.343197E-08   
+WAGS    = -3.04489E-11   PAGS     = 7.522631E-17   B0       = 0              
+B1      = 0              VOFF     = -0.1479099     LVOFF    = 2.28064E-08    
+WVOFF   = 1.625233E-08   PVOFF    = -5.798936E-15  NFACTOR  = 1.2022         
+PNFACTOR= -7.803517E-17  CIT      = -4.928303E-05  LCIT     = -5.160581E-11  
+WCIT    = -4.791258E-11  PCIT     = 1.051096E-16   CDSC     = 0              
+CDSCB   = 0              CDSCD    = 0              ETA0     = 0.0001022582   
+LETA0   = 1.379717E-11   WETA0    = -3.716036E-12  PETA0    = 4.918181E-18   
+ETAB    = 0              DSUB     = 0              PCLM     = 0.8376929      
+LPCLM   = 1.188529E-06   WPCLM    = 1.834269E-08   PPCLM    = -3.669739E-13  
+PDIBLC1 = 0              PDIBLC2  = 0.0002         PDIBLCB  = -0.001         
+DROUT   = 0              PSCBE1   = 5.76E+08       PSCBE2   = 4.01E-06       
+PVAG    = 0              DELTA    = 0.002492423    LDELTA   = 4.853363E-09   
+WDELTA  = 6.634282E-12   PDELTA   = -1.525002E-17  ALPHA0   = 3.956035E-06   
+BETA0   = 30.00601       KT1      = -0.2048516     LKT1     = -2.008925E-07  
+WKT1    = -1.21562E-07   PKT1     = 2.099834E-13   KT2      = -0.01798979    
+LKT2    = -4.078387E-08  WKT2     = -9.379951E-09  PKT2     = 3.362528E-14   
+AT      = 10000          UTE      = -0.7228417     LUTE     = -1.167764E-06  
+WUTE    = -9.261261E-07  PUTE     = 1.246597E-12   UA1      = 6.66716E-10    
+LUA1    = -1.389155E-15  WUA1     = -2.057605E-15  PUA1     = 1.395235E-21   
+UB1     = 0              UC1      = 6.140108E-11   LUC1     = 1.609973E-16   
+WUC1    = -1.904399E-17  PUC1     = -2.019163E-22  KT1L     = 0              
+PRT     = 0              CJ       = cjp3s          MJ       = 0.4796812      
+PB      = 0.9323047      CJSW     = cjswp3s        MJSW     = 0.2978253      
+PBSW    = 0.9323047      CJSWG    = cjgatep3s      MJSWG    = 0.2978253      
+PBSWG   = 0.9323047      CTA      = 0.0008712682   CTP      = 0.0005501537   
+PTA     = 0.001421959    PTP      = 0.001406506    JS       = 5E-07          
+JSW     = 2E-11          CGDO     = cgop3s         CGSO     = cgop3s           
+CAPMOD  = 0              NQSMOD   = 0              XPART    = 1              
+CF      = 0              TLEV     = 1              TLEVC    = 1              
+XTI     = 3              N        = 1              HDIF     = hdifp3s          
+LDIF    = 1.2E-07        RSH      = 3.5            RS       = 0              
+RD      = 0              ACM      = 12             )


.MODEL spch3.2          PMOS   (                    LMIN     = '6.1E-07-dxl3s'  
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '1.21E-06-dxl3s' WMIN    = '1.2E-06-dxw3s' WMAX    = 1.01E-4         
+NLEV    = 3              AF       = 1.3            KF       = 3E-23      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3s'    
+XW      = '0+dxw3s'      VERSION  = 3.1            TOX      = toxp3s           
+XJ      = 1E-07          NCH      = 2.0504E+17     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.675E-08      WINT     = 1.14E-08       MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '-0.56379+dvthp3s' LVTH0= 1.212644E-08   WVTH0    = 3.488961E-08   
+PVTH0   = -2.116055E-14  K1       = 0.6110933      LK1      = -5.835869E-09  
+WK1     = 1.785704E-08   PK1      = -1.08303E-14   K2       = -1.730345E-08  
+LK2     = 4.157306E-18   K3       = 0              DVT0     = 0              
+DVT1    = 0              DVT2     = 0              DVT0W    = 0              
+DVT1W   = 0              DVT2W    = 0              NLX      = 0              
+W0      = 0              K3B      = 0              VSAT     = 109000         
+UA      = 3.887894E-10   LUA      = -6.055679E-17  WUA      = 2.205393E-16   
+PUA     = -6.593224E-23  UB       = 1.235867E-18   LUB      = 4.558625E-26   
+WUB     = -7.950342E-25  PUB      = 3.04294E-31    UC       = 9.054535E-12   
+LUC     = -4.955635E-18  WUC      = -1.053047E-16  PUC      = 4.944336E-23   
+RDSW    = 1211.666       PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.01021924     LU0      = -6.840071E-11  
+WU0     = -2.887461E-10  PU0      = 6.824476E-16   A0       = 0.6351915      
+LA0     = 1.581938E-08   WA0      = 3.046876E-07   PA0      = -1.578331E-13  
+KETA    = 0.001975228    LKETA    = -1.454098E-08  WKETA    = -1.851831E-08  
+PKETA   = 1.123136E-14   A1       = 0              A2       = 0.8019676      
+WA2     = 6.846619E-11   PA2      = -4.152474E-17  AGS      = 0.1827697      
+LAGS    = 3.899409E-12   WAGS     = 6.414706E-11   PAGS     = -3.890519E-17  
+B0      = 0              B1       = 0              VOFF     = -0.1388352     
+LVOFF   = 1.185789E-08   WVOFF    = 2.301584E-08   PVOFF    = -1.395911E-14  
+NFACTOR = 1.202258       LNFACTOR = -6.296603E-11  WNFACTOR = -1.222154E-10  
+PNFACTOR= 7.412361E-17   CIT      = -0.0001257221  LCIT     = 4.061797E-11   
+WCIT    = 7.883837E-11   PCIT     = -4.781548E-17  CDSC     = 0              
+CDSCB   = 0              CDSCD    = 0              ETA0     = -0.0002441169  
+LETA0   = 4.316988E-10   WETA0    = 7.24639E-13    PETA0    = -4.394817E-19  
+ETAB    = 0.0002021666   LETAB    = -2.439141E-10  DSUB     = 0              
+PCLM    = 1.884292       LPCLM    = -7.419352E-08  WPCLM    = -6.759781E-07  
+PPCLM   = 4.707243E-13   PDIBLC1  = 0              PDIBLC2  = -2.166621E-06  
+LPDIBLC2= 2.43914E-10    PDIBLCB  = -0.001         DROUT    = 0              
+PSCBE1  = 5.025805E+08   LPSCBE1  = 88.58062       WPSCBE1  = 26.551         
+PPSCBE1 = -3.203378E-05  PSCBE2   = 4.254008E-06   LPSCBE2  = -2.943957E-13  
+WPSCBE2 = -2.434516E-12  PPSCBE2  = 2.937244E-18   PVAG     = 0              
+DELTA   = 0.00227476     LDELTA   = 5.115973E-09   WDELTA   = -1.207589E-11  
+PDELTA  = 7.324285E-18   ALPHA0   = 3.956035E-06   BETA0    = 30.00601       
+KT1     = -0.4325495     LKT1     = 7.382499E-08   WKT1     = 1.980483E-07   
+PKT1    = -1.756265E-13  KT2      = -0.05997393    LKT2     = 9.870003E-09   
+WKT2    = 4.222098E-08   PKT2     = -2.863125E-14  AT       = 10000          
+UTE     = -2.238818      LUTE     = 6.612622E-07   WUTE     = 7.345064E-07   
+PUTE    = -7.569565E-13  UA1      = -5.926184E-10  LUA1     = 1.302317E-16   
+WUA1    = -6.814672E-16  PUA1     = -2.650764E-22  UB1      = 0              
+UC1     = 3.421141E-10   LUC1     = -1.776831E-16  WUC1     = -3.612112E-16  
+PUC1    = 2.109086E-22   KT1L     = 0              PRT      = 0              
+CJ      = cjp3s          MJ       = 0.4796812      PB       = 0.9323047      
+CJSW    = cjswp3s        MJSW     = 0.2978253      PBSW     = 0.9323047      
+CJSWG   = cjgatep3s      MJSWG    = 0.2978253      PBSWG    = 0.9323047      
+CTA     = 0.0008712682   CTP      = 0.0005501537   PTA      = 0.001421959    
+PTP     = 0.001406506    JS       = 5E-07          JSW      = 2E-11          
+CGDO    = cgop3s         CGSO     = cgop3s         CAPMOD   = 0              
+NQSMOD  = 0              XPART    = 1              CF       = 0              
+TLEV    = 1              TLEVC    = 1              XTI      = 3              
+N       = 1              HDIF     = hdifp3s        LDIF     = 1.2E-07        
+RSH     = 3.5            RS       = 0              RD       = 0              
+ACM     = 12             )


.MODEL spch3.3          PMOS   (                    LMIN     = 3.5E-07        
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '6.1E-07-dxl3s' WMIN    = '1.2E-06-dxw3s' WMAX    = 1.01E-4         
+NLEV    = 3              AF       = 1.3            KF       = 3E-23      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3s'    
+XW      = '0+dxw3s'      VERSION  = 3.1            TOX      = toxp3s           
+XJ      = 1E-07          NCH      = 2.0504E+17     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.675E-08      WINT     = 1.14E-08       MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    ='-0.5744792+dvthp3s' LVTH0= 1.860946E-08   WVTH0    = -9.55025E-09   
+PVTH0   = 5.792226E-15   K1       = 0.5969692      LK1      = 2.730423E-09   
+WK1     = 4.973604E-08   PK1      = -3.016491E-14  K2       = 0.03226146     
+LK2     = -1.956659E-08  WK2      = -2.077243E-08  PK2      = 1.259848E-14   
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 109000         UA       = 5.496497E-10   
+LUA     = -1.581185E-16  WUA      = 1.720323E-16   PUA      = -3.65128E-23   
+UB      = 1.004283E-18   LUB      = 1.860421E-25   WUB      = -1.520182E-25  
+PUB     = -8.569524E-32  UC       = 2.354891E-13   LUC      = 3.931168E-19   
+WUC     = -2.106765E-17  PUC      = -1.646419E-24  RDSW     = 1211.666       
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.009281135    LU0      = 5.005603E-10   WU0      = 1.657415E-09   
+PU0     = -4.978993E-16  A0       = 0.4472083      LA0      = 1.298312E-07   
+WA0     = 1.037118E-07   PA0      = -3.594132E-14  KETA     = -0.04290746    
+LKETA   = 1.268037E-08   WKETA    = 1.779452E-08   PKETA    = -1.079238E-14  
+A1      = 0              A2       = 0.8019745      AGS      = 0.1937701      
+LAGS    = -6.667833E-09  WAGS     = -1.294208E-08  PAGS     = 7.849373E-15   
+B0      = 0              B1       = 0              VOFF     = -0.1358319     
+LVOFF   = 1.003633E-08   WVOFF    = 8.722992E-09   PVOFF    = -5.290494E-15  
+NFACTOR = 2.130581       LNFACTOR = -5.630909E-07  CIT      = -0.00146974    
+LCIT    = 8.55765E-10    CDSC     = 0              CDSCB    = 0              
+CDSCD   = 0              ETA0     = -0.003085425   LETA0    = 2.154952E-09   
+WETA0   = 1.778714E-09   PETA0    = -1.07879E-15   ETAB     = 0.001545832    
+LETAB   = -1.058847E-09  WETAB    = -7.978423E-10  PETAB    = 4.838913E-16   
+DSUB    = 0              PCLM     = 1.158201       LPCLM    = 3.661808E-07   
+WPCLM   = 2.336292E-07   PPCLM    = -8.095252E-14  PDIBLC1  = 0              
+PDIBLC2 = -0.0003996154  LPDIBLC2 = 4.849667E-10   PDIBLCB  = -0.001         
+DROUT   = 0              PSCBE1   = 6.521412E+08   LPSCBE1  = -2.127914      
+WPSCBE1 = -61.27155      PPSCBE1  = 2.123059E-05   PSCBE2   = 3.452234E-06   
+LPSCBE2 = 1.918797E-13   WPSCBE2  = 5.618117E-12   PPSCBE2  = -1.946677E-18  
+PVAG    = 0              DELTA    = 0.01478804     LDELTA   = -2.47333E-09   
+ALPHA0  = 3.956035E-06   BETA0    = 30.00601       KT1      = -0.2559549     
+LKT1    = -3.327962E-08  WKT1     = -2.135008E-07  PKT1     = 7.397803E-14   
+KT2     = -0.04339848    LKT2     = -1.83006E-10   WKT2     = 1.97553E-09    
+PKT2    = -4.222383E-15  AT       = 10000          UTE      = -1.527213      
+LUTE    = 2.296733E-07   WUTE     = 1.133829E-07   PUTE     = -3.802452E-13  
+UA1     = -6.883293E-10  LUA1     = 1.882804E-16   WUA1     = -3.162126E-16  
+PUA1    = -4.866032E-22  UB1      = -9.337619E-21  LUB1     = 5.663265E-27   
+WUB1    = 2.66807E-26    PUB1     = -1.618184E-32  UC1      = 6.303878E-11   
+LUC1    = -8.423844E-18  WUC1     = -4.832723E-17  PUC1     = 2.114442E-23   
+KT1L    = 0              PRT      = 0              CJ       = cjp3s          
+MJ      = 0.4796812      PB       = 0.9323047      CJSW     = cjswp3s        
+MJSW    = 0.2978253      PBSW     = 0.9323047      CJSWG    = cjgatep3s     
+MJSWG   = 0.2978253      PBSWG    = 0.9323047      CTA      = 0.0008712682   
+CTP     = 0.0005501537   PTA      = 0.001421959    PTP      = 0.001406506    
+JS      = 5E-07          JSW      = 2E-11          CGDO     = cgop3s           
+CGSO    = cgop3s         CAPMOD   = 0              NQSMOD   = 0              
+XPART   = 1              CF       = 0              TLEV     = 1              
+TLEVC   = 1              XTI      = 3              N        = 1              
+HDIF    = hdifp3s        LDIF     = 1.2E-07        RSH      = 3.5            
+RS      = 0              RD       = 0              ACM      = 12             )


.MODEL spch3.4          PMOS   (                    LMIN     = '1.21E-06-dxl3s' 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = 2.1E-05        WMIN     = '6E-07-dxw3s'  WMAX     = '1.2E-06-dxw3s'  
+NLEV    = 3              AF       = 1.3            KF       = 3E-23      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3s'    
+XW      = '0+dxw3s'      VERSION  = 3.1            TOX      = toxp3s           
+XJ      = 1E-07          NCH      = 2.0504E+17     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.675E-08      WINT     = 1.14E-08       MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    ='-0.5564612+dvthp3s' LVTH0= -2.857487E-09  WVTH0    = 1.917736E-08   
+PVTH0   = 5.026424E-15   K1       = 0.6025732      LK1      = 2.076266E-08   
+WK1     = 4.267948E-09   PK1      = -1.364574E-14  K2       = -1.73E-08      
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 109000         UA       = 1.532882E-09   
+LUA     = -1.50076E-15   WUA      = -1.611841E-16  PUA      = 4.650793E-22   
+UB      = -8.173826E-20  LUB      = 1.635298E-24   WUB      = 3.483719E-26   
+PUB     = -6.969699E-31  UC       = -5.892266E-11  LUC      = 4.75141E-17    
+WUC     = -1.957298E-17  PUC      = -1.921189E-23  RDSW     = 1211.666       
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.01167516     LU0      = -2.291623E-09  WU0      = 7.90525E-10    
+PU0     = -7.035184E-17  A0       = 0.9778376      LA0      = -4.134017E-07  
+WA0     = 1.456046E-07   PA0      = 5.272215E-14   KETA     = 0.00164039     
+LKETA   = -2.357548E-08  A1       = 0              A2       = 0.802          
+AGS     = 0.1633256      LAGS     = 2.349588E-08   B0       = 0              
+B1      = 0              VOFF     = -0.1294017     LVOFF    = 3.708971E-08   
+WVOFF   = -5.53552E-09   PVOFF    = -2.261325E-14  NFACTOR  = 1.220016       
+LNFACTOR= -2.154991E-08  WNFACTOR = -2.096952E-08  PNFACTOR = 2.529973E-14   
+CIT     = -0.0001183206  LCIT     = 3.780435E-11   WCIT     = 3.335847E-11   
+PCIT    = -1.440686E-19  CDSC     = 0              CDSCB    = 0              
+CDSCD   = 0              ETA0     = 9.910148E-05   LETA0    = 1.797507E-11   
+ETAB    = 0              DSUB     = 0              PCLM     = 0.154165       
+LPCLM   = 1.72027E-06    WPCLM    = 8.22992E-07    PPCLM    = -9.929401E-13  
+PDIBLC1 = 0              PDIBLC2  = 0.0002         PDIBLCB  = -0.001         
+DROUT   = 0              PSCBE1   = 6.834924E+08   LPSCBE1  = -129.6895      
+WPSCBE1 = -126.54        PPSCBE1  = 0.0001526706   PSCBE2   = 4.01E-06       
+PVAG    = 0              DELTA    = 0.002498058    LDELTA   = 4.840409E-09   
+ALPHA0  = 3.956035E-06   BETA0    = 30.00601       KT1      = -0.258778      
+LKT1    = -4.511265E-08  WKT1     = -5.807993E-08  PKT1     = 2.659928E-14   
+KT2     = -0.01155645    LKT2     = -1.113439E-08  WKT2     = -1.695327E-08  
+PKT2    = -1.278096E-15  AT       = 10000          UTE      = -1.440284      
+LUTE    = -3.284816E-07  WUTE     = -8.155303E-08  PUTE     = 2.58594E-13    
+UA1     = -1.075998E-09  LUA1     = -5.259185E-16  WUA1     = -6.082235E-18  
+PUA1    = 3.790321E-22   UB1      = 0              UC1      = 5.309982E-11   
+LUC1    = -5.600792E-17  WUC1     = -9.271757E-18  PUC1     = 5.354231E-23   
+KT1L    = 0              PRT      = 0              CJ       = cjp3s            
+MJ      = 0.4796812      PB       = 0.9323047      CJSW     = cjswp3s          
+MJSW    = 0.2978253      PBSW     = 0.9323047      CJSWG    = cjgatep3s      
+MJSWG   = 0.2978253      PBSWG    = 0.9323047      CTA      = 0.0008712682   
+CTP     = 0.0005501537   PTA      = 0.001421959    PTP      = 0.001406506    
+JS      = 5E-07          JSW      = 2E-11          CGDO     = cgop3s           
+CGSO    = cgop3s         CAPMOD   = 0              NQSMOD   = 0              
+XPART   = 1              CF       = 0              TLEV     = 1              
+TLEVC   = 1              XTI      = 3              N        = 1              
+HDIF    = hdifp3s        LDIF     = 1.2E-07        RSH      = 3.5            
+RS      = 0              RD       = 0              ACM      = 12             )


.MODEL spch3.5          PMOS   (                    LMIN     = '6.1E-07-dxl3s'  
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '1.21E-06-dxl3s' WMIN   = '6E-07-dxw3s'  WMAX     = '1.2E-06-dxw3s'  
+NLEV    = 3              AF       = 1.3            KF       = 3E-23      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3s'    
+XW      = '0+dxw3s'      VERSION  = 3.1            TOX      = toxp3s           
+XJ      = 1E-07          NCH      = 2.0504E+17     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.675E-08      WINT     = 1.14E-08       MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    ='-0.5453712+dvthp3s' LVTH0= -1.623763E-08  WVTH0    = 1.320701E-08   
+PVTH0   = 1.222965E-14   K1       = 0.6273544      LK1      = -9.135944E-09  
+WK1     = -1.285546E-09  PK1      = -6.945446E-15  K2       = -1.730676E-08  
+LK2     = 8.156633E-18   WK2      = 3.902202E-18   PK2      = -4.708008E-24  
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 109000         UA       = 4.751462E-10   
+LUA     = -2.246021E-16  WUA      = 1.1888E-16     PUA      = 1.271819E-22   
+UB      = 8.833288E-19   LUB      = 4.709445E-25   WUB      = -3.800257E-25  
+PUB     = -1.964378E-31  UC       = -6.755756E-11  LUC      = 5.793212E-17   
+WUC     = -1.511693E-17  PUC      = -2.458811E-23  RDSW     = 1211.666       
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.009329465    LU0      = 5.384624E-10   WU0      = 7.586972E-10   
+PU0     = -3.195172E-17  A0       = 0.6826806      LA0      = -5.729485E-08  
+WA0     = 2.487834E-07   PA0      = -7.176308E-14  KETA     = -0.01375558    
+LKETA   = -5.000241E-09  A1       = 0              A2       = 0.8020258      
+LA2     = -3.11122E-11   AGS      = 0.133075       LAGS     = 5.99932E-08    
+WAGS    = 5.85647E-08    PAGS     = -7.065832E-14  B0       = 0              
+B1      = 0              VOFF     = -0.07781284    LVOFF    = -2.515219E-08  
+WVOFF   = -4.881975E-08  PVOFF    = 2.960917E-14   NFACTOR  = 1.202155       
+CIT     = -0.0001155282  LCIT     = 3.443538E-11   WCIT     = 6.683817E-11   
+PCIT    = -4.053735E-17  CDSC     = 0              CDSCB    = 0              
+CDSCD   = 0              ETA0     = -0.0002435014  LETA0    = 4.313254E-10   
+ETAB    = 0.0002021666   LETAB    = -2.439141E-10  DSUB     = 0              
+PCLM    = 1.399872       LPCLM    = 2.173244E-07   WPCLM    = -1.057185E-07  
+PPCLM   = 1.275494E-13   PDIBLC1  = 0              PDIBLC2  = -2.166644E-06  
+LPDIBLC2= 2.439141E-10   PDIBLCB  = -0.001         DROUT    = 0              
+PSCBE1  = 5.555872E+08   LPSCBE1  = 24.62807       WPSCBE1  = -35.84846      
+PPSCBE1 = 4.325117E-05   PSCBE2   = 2.185951E-06   LPSCBE2  = 2.200715E-12   
+PVAG    = 0              DELTA    = 0.002264501    LDELTA   = 5.122195E-09   
+ALPHA0  = 3.956035E-06   BETA0    = 30.00601       KT1      = -0.2027321     
+LKT1    = -1.127319E-07  WKT1     = -7.249273E-08  PKT1     = 4.398833E-14   
+KT2     = 0.006659874    LKT2     = -3.31124E-08   WKT2     = -3.622035E-08  
+PKT2    = 2.196764E-14   AT       = 10000          UTE      = -1.841684      
+LUTE    = 1.558078E-07   WUTE     = 2.670003E-07   PUTE     = -1.619357E-13  
+UA1     = -1.701956E-09  LUA1     = 2.292999E-16   WUA1     = 6.244454E-16   
+PUA1    = -3.816996E-22  UB1      = 0              UC1      = -2.217555E-11  
+LUC1    = 3.481183E-17   WUC1     = 6.763064E-17   PUC1     = -3.924044E-23  
+KT1L    = 0              PRT      = 0              CJ       = cjp3s            
+MJ      = 0.4796812      PB       = 0.9323047      CJSW     = cjswp3s          
+MJSW    = 0.2978253      PBSW     = 0.9323047      CJSWG    = cjgatep3s     
+MJSWG   = 0.2978253      PBSWG    = 0.9323047      CTA      = 0.0008712682   
+CTP     = 0.0005501537   PTA      = 0.001421959    PTP      = 0.001406506    
+JS      = 5E-07          JSW      = 2E-11          CGDO     = cgop3s           
+CGSO    = cgop3s         CAPMOD   = 0              NQSMOD   = 0              
+XPART   = 1              CF       = 0              TLEV     = 1              
+TLEVC   = 1              XTI      = 3              N        = 1              
+HDIF    = hdifp3s        LDIF     = 1.2E-07        RSH      = 3.5            
+RS      = 0              RD       = 0              ACM      = 12             )


.MODEL spch3.6          PMOS   (                    LMIN     = 3.5E-07        
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '6.1E-07-dxl3s' WMIN    = '6E-07-dxw3s'  WMAX     = '1.2E-06-dxw3s'  
+NLEV    = 3              AF       = 1.3            KF       = 3E-23      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3s'    
+XW      = '0+dxw3s'      VERSION  = 3.1            TOX      = toxp3s           
+XJ      = 1E-07          NCH      = 2.0504E+17     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.675E-08      WINT     = 1.14E-08       MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    ='-0.6126782+dvthp3s' LVTH0= 2.458411E-08   WVTH0    = 3.54177E-08    
+PVTH0   = -1.241133E-15  K1       = 0.6224356      LK1      = -6.152668E-09  
+WK1     = 1.975697E-08   PK1      = -1.970773E-14  K2       = 0.0216375      
+LK2     = -1.312315E-08  WK2      = -8.265895E-09  PK2      = 5.013266E-15   
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 109000         UA       = -6.480332E-11  
+LUA     = 1.028773E-16   WUA      = 8.953666E-16   PUA      = -3.437572E-22  
+UB      = 2.197671E-18   LUB      = -3.262038E-25  WUB      = -1.556874E-24  
+PUB     = 5.173208E-31   UC       = 6.597368E-11   LUC      = -2.305458E-17  
+WUC     = -9.845466E-17  PUC      = 2.595622E-23   RDSW     = 1211.666       
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.009557324    LU0      = 4.002666E-10   WU0      = 1.332286E-09   
+PU0     = -3.798336E-16  A0       = 0.761454       LA0      = -1.050709E-07  
+WA0     = -2.662184E-07  PA0      = 2.405855E-13   KETA     = -0.02779149    
+LKETA   = 3.512534E-09   A1       = 0              A2       = 0.8019745      
+AGS     = 0.5008327      LAGS     = -1.630519E-07  WAGS     = -3.744163E-07  
+PAGS    = 1.919447E-13   B0       = 0              B1       = 0              
+VOFF    = -0.1509316     LVOFF    = 1.919435E-08   WVOFF    = 2.649845E-08   
+PVOFF   = -1.607131E-14  NFACTOR  = 2.661979       LNFACTOR = -8.853833E-07  
+WNFACTOR= -6.255687E-07  PNFACTOR = 3.794074E-13   CIT      = -0.002879354   
+LCIT    = 1.710696E-09   WCIT     = 1.659398E-09   PCIT     = -1.006425E-15  
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = -0.0002924053  LETA0    = 4.609855E-10   WETA0    = -1.509229E-09  
+PETA0   = 9.153472E-16   ETAB     = 0.0008680861   LETAB    = -6.477942E-10  
+DSUB    = 0              PCLM     = 1.575381       LPCLM    = 1.108779E-07   
+WPCLM   = -2.574756E-07  PPCLM    = 2.195901E-13   PDIBLC1  = 0              
+PDIBLC2 = -0.0003996153  LPDIBLC2 = 4.849667E-10   PDIBLCB  = -0.001         
+DROUT   = 0              PSCBE1   = 8.196894E+08   LPSCBE1  = -135.55        
+WPSCBE1 = -258.5094      PPSCBE1  = 0.000178295    PSCBE2   = 8.224674E-06   
+LPSCBE2 = -1.461771E-12  PVAG     = 0              DELTA    = 0.02274803     
+LDELTA  = -7.301064E-09  WDELTA   = -9.370502E-09  PDELTA   = 5.683209E-15   
+ALPHA0  = 3.956035E-06   BETA0    = 30.00601       KT1      = -0.4503371     
+LKT1    = 3.744048E-08   WKT1     = 1.532589E-08   PKT1     = -9.273659E-15  
+KT2     = -0.01941264    LKT2     = -1.729942E-08  WKT2     = -2.626061E-08  
+PKT2    = 1.592706E-14   AT       = 10000          UTE      = -1.301911      
+LUTE    = -1.715644E-07  WUTE     = -1.518416E-07  PUTE     = 9.209191E-14   
+UA1     = -5.906874E-10  LUA1     = -4.446844E-16  WUA1     = -4.311567E-16  
+PUA1    = 2.585229E-22   UB1      = 2.614742E-20   LUB1     = -1.585841E-26  
+WUB1    = -1.509229E-26  PUB1     = 9.153473E-33   UC1      = 2.449626E-11   
+LUC1    = 6.50538E-18    WUC1     = -2.954987E-18  PUC1     = 3.569736E-24   
+KT1L    = 0              PRT      = 0              CJ       = cjp3s           
+MJ      = 0.4796812      PB       = 0.9323047      CJSW     = cjswp3s         
+MJSW    = 0.2978253      PBSW     = 0.9323047      CJSWG    = cjgatep3s       
+MJSWG   = 0.2978253      PBSWG    = 0.9323047      CTA      = 0.0008712682   
+CTP     = 0.0005501537   PTA      = 0.001421959    PTP      = 0.001406506  
+JS      = 5E-07          JSW      = 2E-11          CGDO     = cgop3s         
+CGSO    = cgop3s         CAPMOD   = 0              NQSMOD   = 0              
+XPART   = 1              CF       = 0              TLEV     = 1              
+TLEVC   = 1              XTI      = 3              N        = 1              
+HDIF    = hdifp3s        LDIF     = 1.2E-07        RSH      = 3.5            
+RS      = 0              RD       = 0              ACM      = 12             )


.MODEL spch3.7          PMOS   (                    LMIN     = '1.21E-06-dxl3s' 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = 2.1E-05        WMIN     = 3E-07          WMAX     = '6E-07-dxw3s'    
+NLEV    = 3              AF       = 1.3            KF       = 3E-23      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3s'    
+XW      = '0+dxw3s'      VERSION  = 3.1            TOX      = toxp3s           
+XJ      = 1E-07          NCH      = 2.0504E+17     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.675E-08      WINT     = 1.14E-08       MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    ='-0.5382503+dvthp3s' LVTH0= 1.923162E-08   WVTH0    = 8.666028E-09   
+PVTH0   = -7.723409E-15  K1       = 0.6101473      LK1      = 2.749076E-09   
+WK1     = -1.038402E-10  PK1      = -3.248297E-15  K2       = -1.73E-08      
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 109000         UA       = 1.474827E-09   
+LUA     = -1.073953E-15  WUA      = -1.276745E-16  PUA      = 2.187263E-22   
+UB      = -4.108128E-20  LUB      = 8.218942E-25   WUB      = 1.136994E-26   
+PUB     = -2.274732E-31  UC       = -8.474858E-11  LUC      = 2.250746E-17   
+WUC     = -4.666254E-18  PUC      = -4.778058E-24  RDSW     = 1211.666       
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.01223033     LU0      = -2.137094E-09  WU0      = 4.700829E-10   
+PU0     = -1.595457E-16  A0       = 1.154975       LA0      = -4.089013E-07  
+WA0     = 4.33612E-08    PA0      = 5.012453E-14   KETA     = 0.00164039     
+LKETA   = -2.357548E-08  A1       = 0              A2       = 0.802          
+AGS     = 0.1633256      LAGS     = 2.349588E-08   B0       = 0              
+B1      = 0              VOFF     = -0.1080459     LVOFF    = -4.588387E-08  
+WVOFF   = -1.786209E-08  PVOFF    = 2.52791E-14    NFACTOR  = 1.183686       
+LNFACTOR= 2.228191E-08   CIT      = -0.001103239   LCIT     = 1.328358E-09   
+WCIT    = 6.018532E-10   PCIT     = -7.450517E-16  CDSC     = 0              
+CDSCB   = 0              CDSCD    = 0              ETA0     = 9.910154E-05   
+LETA0   = 1.7975E-11     ETAB     = 0              DSUB     = 0              
+PCLM    = 1.575315       LPCLM    = 9.372158E-08   WPCLM    = 2.703923E-09   
+PPCLM   = -5.40961E-14   PDIBLC1  = 0              PDIBLC2  = 0.0002         
+PDIBLCB = -0.001         DROUT    = 0              PSCBE1   = 4.642616E+08   
+LPSCBE1 = 134.8124       PSCBE2   = 4.01E-06       PVAG     = 0              
+DELTA   = -0.0004616684  LDELTA   = 8.41132E-09    WDELTA   = 1.708355E-09   
+PDELTA  = -2.06113E-15   ALPHA0   = 3.956035E-06   BETA0    = 30.00601       
+KT1     = -0.4021538     LKT1     = 3.575677E-08   WKT1     = 2.467665E-08   
+PKT1    = -2.007856E-14  KT2      = -0.05243992    LKT2     = -1.36533E-08   
+WKT2    = 6.644667E-09   PKT2     = 1.758192E-16   AT       = 10000          
+UTE     = -1.872831      LUTE     = 4.308E-07      WUTE     = 1.681134E-07   
+PUTE    = -1.796634E-13  UA1      = -1.795437E-09  LUA1     = 1.195729E-15   
+WUA1    = 4.091781E-16   PUA1     = -6.147029E-22  UB1      = 0              
+UC1     = -4.109661E-12  LUC1     = 1.911877E-16   WUC1     = 2.374956E-17   
+PUC1    = -8.913902E-23  KT1L     = 0              PRT      = 0              
+CJ      = cjp3s          MJ       = 0.4796812      PB       = 0.9323047      
+CJSW    = cjswp3s        MJSW     = 0.2978253      PBSW     = 0.9323047      
+CJSWG   = cjgatep3s      MJSWG    = 0.2978253      PBSWG    = 0.9323047      
+CTA     = 0.0008712682   CTP      = 0.0005501537   PTA      = 0.001421959    
+PTP     = 0.001406506    JS       = 5E-07          JSW      = 2E-11          
+CGDO    = cgop3s         CGSO     = cgop3s         CAPMOD   = 0              
+NQSMOD  = 0              XPART    = 1              CF       = 0              
+TLEV    = 1              TLEVC    = 1              XTI      = 3              
+N       = 1              HDIF     = hdifp3s        LDIF     = 1.2E-07        
+RSH     = 3.5            RS       = 0              RD       = 0              
+ACM     = 12             )


.MODEL spch3.8          PMOS   (                    LMIN     = '6.1E-07-dxl3s'  
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '1.21E-06-dxl3s' WMIN   = 3E-07          WMAX     = '6E-07-dxw3s'    
+NLEV    = 3              AF       = 1.3            KF       = 3E-23      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3s'    
+XW      = '0+dxw3s'      VERSION  = 3.1            TOX      = toxp3s           
+XJ      = 1E-07          NCH      = 2.0504E+17     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.675E-08      WINT     = 1.14E-08       MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    ='-0.5281616+dvthp3s' LVTH0= 7.059651E-09   WVTH0    = 3.273682E-09   
+PVTH0   = -1.217542E-15  K1       = 0.632612       LK1      = -2.435456E-08  
+WK1     = -4.320199E-09  PK1      = 1.838739E-15   K2       = -1.73E-08      
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 109000         UA       = 4.856069E-10   
+LUA     = 1.195403E-16   WUA      = 1.128421E-16   PUA      = -7.145708E-23  
+UB      = 4.898184E-19   LUB      = 1.813637E-25   WUB      = -1.528915E-25  
+PUB     = -2.929179E-32  UC       = -8.596529E-11  LUC      = 2.397541E-17   
+WUC     = -4.491995E-18  PUC      = -4.988303E-24  RDSW     = 1211.666       
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.0100171      LU0      = 5.331663E-10   WU0      = 3.617936E-10   
+PU0     = -2.889479E-17  A0       = 0.8048083      LA0      = 1.357416E-08   
+WA0     = 1.782913E-07   PA0      = -1.126687E-13  KETA     = -0.006358222   
+LKETA   = -1.392516E-08  WKETA    = -4.269756E-09  PKETA    = 5.151461E-15   
+A1      = 0              A2       = 0.8020258      LA2      = -3.11122E-11   
+AGS     = 0.1449015      LAGS     = 4.572449E-08   WAGS     = 5.173844E-08   
+PAGS    = -6.242243E-14  B0       = 0              B1       = 0              
+VOFF    = -0.1669535     LVOFF    = 2.518823E-08   WVOFF    = 2.632252E-09   
+PVOFF   = 5.52682E-16    NFACTOR  = 1.447338       LNFACTOR = -2.958135E-07  
+WNFACTOR= -1.415197E-07  PNFACTOR = 1.707435E-13   CIT      = 6.007417E-05   
+LCIT    = -7.517906E-11  WCIT     = -3.451954E-11  PCIT     = 2.273211E-17   
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = -0.0004180399  LETA0    = 6.419061E-10   WETA0    = 1.007436E-10   
+PETA0   = -1.215471E-16  ETAB     = 0.0002021666   LETAB    = -2.439141E-10  
+DSUB    = 0              PCLM     = 1.018467       LPCLM    = 7.655589E-07   
+WPCLM   = 1.144282E-07   PPCLM    = -1.888915E-13  PDIBLC1  = 0              
+PDIBLC2 = -2.166644E-06  LPDIBLC2 = 2.439141E-10   PDIBLCB  = -0.001         
+DROUT   = 0              PSCBE1   = 4.934796E+08   LPSCBE1  = 99.5608        
+PSCBE2  = 2.185951E-06   LPSCBE2  = 2.200715E-12   PVAG     = 0              
+DELTA   = 0.002264501    LDELTA   = 5.122195E-09   ALPHA0   = 3.956035E-06   
+BETA0   = 30.00601       KT1      = -0.3534423     LKT1     = -2.301377E-08  
+WKT1    = 1.449716E-08   PKT1     = -7.797001E-15  KT2      = -0.07974812    
+LKT2    = 1.929405E-08   WKT2     = 1.365435E-08   PKT2     = -8.281362E-15  
+AT      = 10000          UTE      = -1.527704      LUTE     = 1.440395E-08   
+WUTE    = 8.577107E-08   PUTE     = -8.031732E-14  UA1      = -3.299681E-10  
+LUA1    = -5.723596E-16  WUA1     = -1.674661E-16  PUA1     = 8.101829E-23   
+UB1     = 0              UC1      = 2.658163E-10   LUC1     = -1.34478E-16   
+WUC1    = -9.859825E-17  PUC1     = 5.847363E-23   KT1L     = 0              
+PRT     = 0              CJ       = cjp3s          MJ       = 0.4796812      
+PB      = 0.9323047      CJSW     = cjswp3s        MJSW     = 0.2978253      
+PBSW    = 0.9323047      CJSWG    = cjgatep3s      MJSWG    = 0.2978253      
+PBSWG   = 0.9323047      CTA      = 0.0008712682   CTP      = 0.0005501537   
+PTA     = 0.001421959    PTP      = 0.001406506    JS       = 5E-07          
+JSW     = 2E-11          CGDO     = cgop3s         CGSO     = cgop3s           
+CAPMOD  = 0              NQSMOD   = 0              XPART    = 1              
+CF      = 0              TLEV     = 1              TLEVC    = 1              
+XTI     = 3              N        = 1              HDIF     = hdifp3s          
+LDIF    = 1.2E-07        RSH      = 3.5            RS       = 0              
+RD      = 0              ACM      = 12             )


.MODEL spch3.9          PMOS   (                    LMIN     = 3.5E-07        
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = '6.1E-07-dxl3s' WMIN    = 3E-07          WMAX     = '6E-07-dxw3s'    
+NLEV    = 3              AF       = 1.3            KF       = 3E-23      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxl3s'    
+XW      = '0+dxw3s'      VERSION  = 3.1            TOX      = toxp3s           
+XJ      = 1E-07          NCH      = 2.0504E+17     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 1.675E-08      WINT     = 1.14E-08       MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    ='-0.5506886+dvthp3s' LVTH0= 2.072224E-08  WVTH0    = -3.627248E-10  
+PVTH0   = 9.879383E-16   K1       = 0.6449367      LK1      = -3.182947E-08  
+WK1     = 6.76937E-09    PK1      = -4.887082E-15  K2       = 0.0140776      
+LK2     = -8.538072E-09  WK2      = -3.902322E-09  PK2      = 2.366757E-15   
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 109000         UA       = 1.485543E-09   
+LUA     = -4.869207E-16  WUA      = 5.069126E-19   PUA      = -3.32577E-24   
+UB      = -6.567034E-19  LUB      = 8.767291E-25   WUB      = 9.067045E-26   
+PUB     = -1.77012E-31   UC       = -1.340419E-10  LUC      = 5.313389E-17   
+WUC     = 1.699434E-17   PUC      = -1.801976E-23  RDSW     = 1211.666       
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.01197966     LU0      = -6.571245E-10  WU0      = -6.588546E-11  
+PU0     = 2.304925E-16   A0       = 0.3304489      LA0      = 3.012731E-07   
+WA0     = -1.744226E-08  PA0      = 6.043743E-15   KETA     = -0.0389922     
+LKETA   = 5.86735E-09    WKETA    = 6.465052E-09   PKETA    = -1.3592E-15    
+A1      = 0              A2       = 0.8019745      AGS      = -0.1362121     
+LAGS    = 2.162199E-07   WAGS     = -6.714084E-09  PAGS     = -2.697098E-14  
+B0      = 0              B1       = 0              VOFF     = -0.1193438     
+LVOFF   = -3.687087E-09  WVOFF    = 8.265935E-09   PVOFF    = -2.864146E-15  
+NFACTOR = 1.012372       LNFACTOR = -3.2007E-08    WNFACTOR = 3.26584E-07    
+PNFACTOR= -1.131613E-13  CIT      = -1.641197E-05  LCIT     = -2.879021E-11  
+WCIT    = 6.907699E-12   PCIT     = -2.393518E-18  CDSC     = 0              
+CDSCB   = 0              CDSCD    = 0              ETA0     = -0.002504366   
+LETA0   = 1.907263E-09   WETA0    = -2.32485E-10   PETA0    = 8.055608E-17   
+ETAB    = 0.0008680863   LETAB    = -6.477943E-10  DSUB     = 0              
+PCLM    = 1.380014       LPCLM    = 5.46281E-07    WPCLM    = -1.447093E-07  
+PPCLM   = -3.172457E-14  PDIBLC1  = 0              PDIBLC2  = -0.0003996154  
+LPDIBLC2= 4.849667E-10   PDIBLCB  = -0.001         DROUT    = 0              
+PSCBE1  = 9.340001E+07   LPSCBE1  = 342.209        WPSCBE1  = 160.7048       
+PPSCBE1 = -9.746743E-05  PSCBE2   = 8.224674E-06   LPSCBE2  = -1.461771E-12  
+PVAG    = 0              DELTA    = 0.006513617    LDELTA   = 2.545106E-09   
+ALPHA0  = 3.956035E-06   BETA0    = 30.00601       KT1      = -0.2859621     
+LKT1    = -6.394043E-08  WKT1     = -7.955133E-08  PKT1     = 4.92434E-14    
+KT2     = -0.05450874    LKT2     = 3.986369E-09   WKT2     = -6.003139E-09  
+PKT2    = 3.640904E-15   AT       = 10000          UTE      = -0.219536      
+LUTE    = -7.79E-07      WUTE     = -7.765885E-07  PUTE     = 4.427037E-13   
+UA1     = 1.037243E-09   LUA1     = -1.401572E-15  WUA1     = -1.370797E-15  
+PUA1    = 8.108385E-22   UB1      = 0              UC1      = 1.896359E-11   
+LUC1    = 1.52382E-17    WUC1     = 2.384738E-19   PUC1     = -1.470846E-24  
+KT1L    = 0              PRT      = 0              CJ       = cjp3s          
+MJ      = 0.4796812      PB       = 0.9323047      CJSW     = cjswp3s        
+MJSW    = 0.2978253      PBSW     = 0.9323047      CJSWG    = cjgatep3s      
+MJSWG   = 0.2978253      PBSWG    = 0.9323047      CTA      = 0.0008712682   
+CTP     = 0.0005501537   PTA      = 0.001421959    PTP      = 0.001406506    
+JS      = 5E-07          JSW      = 2E-11          CGDO     = cgop3s           
+CGSO    = cgop3s         CAPMOD   = 0              NQSMOD   = 0              
+XPART   = 1              CF       = 0              TLEV     = 1              
+TLEVC   = 1              XTI      = 3              N        = 1              
+HDIF    = hdifp3s        LDIF     = 1.2E-07        RSH      = 3.5            
+RS      = 0              RD       = 0              ACM      = 12             )
*
*
*
.ENDL MOS_3VS
*
*
.LIB ESD
***************************************************************
*          3.3V Nominal Vt NMOS DEVICES MODEL                 *
*                  WITH ESD IMPLANT                           *
***************************************************************
*
.MODEL ech3 NMOS (                                 LEVEL   = 49                 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+VERSION = 3.1            LMIN    = 5E-7           LMAX    = 2E-6               
+WMIN    = 1.5E-5         WMAX    = 2E-4           XL      = '0.03E-6+dxle3'   
+XW      = '0+dxwe3'      TNOM    = 25             TOX     = toxe3             
+XJ      = 1.5E-7         NCH     = 1.69E17        LLN     = 1                  
+LWN     = 1              WLN     = 1              WWN     = 1                  
+LINT    = 1.99E-8        WINT    = 1.88E-8        MOBMOD  = 1                  
+BINUNIT = 2              DWG     = 0              DWB     = 0                  
+VTH0    = 'dvthe3+0.538667' LVTH0 = -2.675774E-9  WVTH0   = 1.201026E-7        
+PVTH0   = -1.28983E-13   K1      = 0.4968983      LK1     = 1.770367E-8        
+WK1     = 3.077284E-8    PK1     = -1.63590E-13   K2      = 0.0300104          
+LK2     = -1.783164E-8   WK2     = 1.179027E-8    PK2     = 4.669794E-15       
+K3      = 0              DVT0    = 0              DVT1    = 0                  
+DVT2    = 0              DVT0W   = 0              DVT1W   = 0                  
+DVT2W   = 0              NLX     = 0              W0      = 0                  
+K3B     = 0              VSAT    = 1.04E5         UA      = -6.09396E-10       
+LUA     = -1.75579E-16   WUA     = -2.79729E-15   PUA     = 6.362498E-21       
+UB      = 1.526094E-18   LUB     = 3.894086E-25   WUB     = 2.318054E-24       
+PUB     = -5.38885E-30   UC      = 2.446888E-11   LUC     = 3.056293E-17       
+WUC     = 3.914042E-17   PUC     = -2.66895E-23   RDSW    = 121.98167          
+PRWB    = 2.91E-11       PRWG    = 2.91E-11       WR      = 0.73               
+U0      = 0.0315176      LU0     = -4.45912E-10   WU0     = -1.446996E-8       
+PU0     = 3.686383E-14   A0      = 1.7009453      LA0     = -6.640547E-7       
+WA0     = -4.15121E-6    PA0     = 3.642564E-12   KETA    = -7.859678E-3       
+LKETA   = 2.773914E-10   WKETA   = -3.895231E-8   PKETA   = -2.13182E-14       
+A1      = 0              A2      = 1.065825       LA2     = -2.339897E-7       
+WA2     = -2.376851E-7   PA2     = 4.801713E-13   AGS     = 0.3667209          
+LAGS    = -1.584547E-7   WAGS    = 1.034402E-7    PAGS    = -3.75730E-13       
+B0      = 0              B1      = 0              VOFF    = -0.1602946         
+LVOFF   = -1.151879E-8   WVOFF   = 9.268059E-8    PVOFF   = -1.39229E-13       
+NFACTOR = 2.1421781      LNFACTOR= -6.549162E-7   WNFACTOR= 6.269482E-7        
+PNFACTOR= -2.05297E-12   CIT     = -2.094649E-4   LCIT    = 3.34917E-10        
+WCIT    = -3.046879E-9   PCIT    = 5.195496E-15   CDSC    = 0                  
+CDSCB   = 0              CDSCD   = 2.91E-11       ETA0    = 1.113719E-5        
+LETA0   = -2.29736E-12   WETA0   = -1.13677E-10   PETA0   = 2.296493E-16       
+ETAB    = 1.554666E-4    LETAB   = -3.14074E-10   WETAB   = 1.372558E-9        
+PETAB   = -2.77284E-15   DSUB    = 0              PCLM    = 1.4412937          
+LPCLM   = 8.058956E-8    WPCLM   = -3.468443E-6   PPCLM   = 2.784211E-12       
+PDIBLC1 = 0              PDIBLC2 = 5.271764E-3    LPDIBLC2= -5.49016E-10       
+WPDIBLC2= -2.716612E-8   PPDIBLC2= 5.4881E-14     PDIBLCB = 0.1820228          
+LPDIBLCB= 9.351745E-9    WPDIBLCB= 1.790962E-7    PPDIBLCB= -9.31658E-14       
+DROUT   = 0              PSCBE1  = 3.484928E8     LPSCBE1 = -32.73701          
+WPSCBE1 = -721.8098      PPSCBE1 = 6.001474E-4    PSCBE2  = 5.987646E-6        
+LPSCBE2 = -2.33447E-12   WPSCBE2 = -4.47077E-11   PPSCBE2 = 2.325696E-17       
+PVAG    = 5.451575       LPVAG   = -2.597972E-6   WPVAG   = -5.563467E-5       
+PPVAG   = 2.855657E-11   DELTA   = -2.366685E-3   LDELTA  = 1.00553E-8         
+WDELTA  = 3.742707E-8    PDELTA  = -9.79640E-14   ALPHA0  = 0                  
+BETA0   = 30             KT1     = -0.333394      LKT1    = 1.660288E-9        
+WKT1    = -1.654576E-7   PKT1    = 2.581405E-13   KT2     = -0.0313848         
+LKT2    = 1.428912E-9    WKT2    = 5.129326E-8    PKT2    = -5.23984E-14       
+AT      = -670.4982      LAT     = -3.906036E-4   WAT     = -0.015951          
+PAT     = 4.728915E-9    UTE     = -1.0817207     LUTE    = -1.222841E-7       
+WUTE    = 1.080394E-7    PUTE    = -1.78303E-12   UA1     = 2.267406E-9        
+LUA1    = -2.76328E-16   WUA1    = 3.552807E-15   PUA1    = -1.17995E-20       
+UB1     = -1.94603E-18   LUB1    = -7.72466E-26   WUB1    = -5.59128E-24       
+PUB1    = 1.354413E-29   UC1     = -2.56681E-11   LUC1    = 7.655498E-18       
+WUC1    = -2.75498E-16   PUC1    = 3.285472E-22   KT1L    = 0                  
+PRT     = -0.1691113     LPRT    = 2.901957E-7    WPRT    = 1.160136E-6        
+PPRT    = -2.61814E-12   CJ      = cje3           MJ      = 0.376203           
+PB      = 0.8351256      CJSW    = cjswe3         MJSW    = 0.2945822          
+PBSW    = 0.8351256      CJSWG   = cjgatee3       MJSWG   = 0.2945822          
+PBSWG   = 0.8351256      HDIF    = hdife3         LDIF    = 1.2E-7             
+ACM     = 12             RS      = 0              RD      = 0                  
+RSH     = 60             CTA     = 9.368412E-4    CTP     = 5.837846E-4        
+PTA     = 1.743614E-3    PTP     = 1.743614E-3    CGDO    = cgoe3          
+CGSO    = cgoe3          CAPMOD  = 0              NQSMOD  = 0              
+XPART   = 1              CF      = 0              TLEV    = 1
+TLEVC   = 1              N       = 1              XTI     = 3
+JS      = 1.050984E-6    JSW     = 6.465319E-11    )  
*
.ENDL ESD
*
.LIB MOSM2
*
*
*
***************************************************************
*                                                             *
*                                                             *
*               2.5V MEDIUM VT DEVICES MODEL                  *
*                                                             *
*                                                             *
*                                                             *
***************************************************************
*
**************************************************************************
*
*
***************************************************************
*                                                             *
*                 NMOS DEVICES MODEL                          *
*                                                             *
***************************************************************
*
*
.MODEL mnch2            NMOS   (                    LMIN     = 3.5E-07        
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = 2E-05          WMIN     = 3E-07          WMAX     = 1E-05          
+NLEV    = 3              AF       = 1.05           KF       = 1.5E-23      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxlm'    
+XW      = '0+dxwm'       VERSION  = 3.1            TOX      = toxnm           
+XJ      = 1E-07          NCH      = 9.476E+16      LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 2.35E-08       WINT     = 2E-09          MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    = '0.174829+dvthnm'  LVTH0= 4.179474E-08   WVTH0    = -6.239694E-09  
+PVTH0   = 9.503237E-16   K1       = 0.197929       LK1      = 2.615392E-08   
+WK1     = 7.597396E-09   PK1      = 5.681334E-16   K2       = 0.01964949     
+LK2     = -1.09982E-08   K3       = 0              DVT0     = 0              
+DVT1    = 0              DVT2     = 0              DVT0W    = 0              
+DVT1W   = 0              DVT2W    = 0              NLX      = 0              
+W0      = 0              K3B      = 0              VSAT     = 80063.55       
+LVSAT   = -0.001270537   WVSAT    = -8.78324E-06   PVSAT    = 1.756037E-10   
+UA      = -5.421263E-10  LUA      = -3.60329E-17   WUA      = 3.920138E-17   
+PUA     = 1.369708E-24   UB       = 2.037398E-18   LUB      = 4.733001E-26   
+WUB     = -9.595713E-26  PUB      = -3.305482E-32  UC       = 2.980125E-11   
+LUC     = 5.43574E-18    WUC      = -9.70181E-18   PUC      = -5.133829E-25  
+RDSW    = 184            PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.03888641     LU0      = 1.061519E-09   
+WU0     = -2.564712E-10  PU0      = 3.811612E-16   A0       = 0.08526196     
+LA0     = 1.705043E-07   WA0      = 6.469923E-08   PA0      = -5.248404E-14  
+KETA    = -0.01418984    LKETA    = 3.268259E-09   WKETA    = 3.067796E-09   
+PKETA   = -1.053619E-16  A1       = 0              A2       = 0.99           
+AGS     = 0              B0       = 0              B1       = 0              
+VOFF    = -0.1048087     LVOFF    = -8.48859E-09   WVOFF    = 4.404829E-09   
+PVOFF   = -1.466808E-15  NFACTOR  = 0.403102       LNFACTOR = 2.77907E-07    
+CIT     = 0.0006970345   LCIT     = 2.058801E-11   CDSC     = 0              
+CDSCB   = 0              CDSCD    = 0              ETA0     = 0.0003942014   
+LETA0   = 7.778209E-10   WETA0    = 1.107412E-10   PETA0    = -3.68768E-17   
+ETAB    = -1.966855E-05  LETAB    = -4.32479E-10   WETAB    = 1.963338E-12   
+PETAB   = -3.92526E-17   DSUB     = 0              PCLM     = 2.000379       
+LPCLM   = -7.581719E-09  WPCLM    = -7.231082E-09  PPCLM    = 1.445715E-13   
+PDIBLC1 = 0              PDIBLC2  = 0.005773039    LPDIBLC2 = 4.737578E-09   
+PDIBLCB = 0.1938122      LPDIBLCB = -3.383351E-08  DROUT    = 0              
+PSCBE1  = 3.52462E+08    LPSCBE1  = 130.7152       PSCBE2   = 1E-20          
+PVAG    = 0              DELTA    = 0.01           ALPHA0   = 1.07E-06       
+BETA0   = 16.6052        KT1      = -0.2311565     LKT1     = -9.796265E-09  
+WKT1    = 1.408586E-09   PKT1     = 1.111055E-15   KT2      = -0.01900227    
+LKT2    = 3.489735E-11   WKT2     = 5.742665E-12   PKT2     = -1.032961E-17  
+AT      = 10413.73       LAT      = 0.003694762    WAT      = 5.955642E-05   
+PAT     = -8.979859E-10  UTE      = -1.330061      LUTE     = -2.406742E-07  
+WUTE    = -3.578418E-09  PUTE     = 7.123956E-14   UA1      = 2.151539E-09   
+LUA1    = -8.562816E-16  WUA1     = -1.789531E-16  PUA1     = 3.021748E-22   
+UB1     = -2.042209E-18  LUB1     = 6.421123E-25   WUB1     = 1.043123E-26   
+PUB1    = -1.900652E-31  UC1      = -5.252641E-11  LUC1     = 8.530071E-18   
+WUC1    = -3.809119E-20  PUC1     = 7.136592E-25   KT1L     = 0              
+PRT     = 0              CJ       = cjnm           MJ       = 0.5615669      
+PB      = 0.9886598      CJSW     = cjswnm         MJSW     = 0.4084017      
+PBSW    = 0.9886598      CJSWG    = cjgatenm       MJSWG    = 0.4084017      
+PBSWG   = 0.9886598      CTA      = 0.0008831687   CTP      = 0.0001834847   
+PTA     = 0.001343084    PTP      = 0.001343084    JS       = 2E-06          
+JSW     = 1.5E-10        CGDO     = cgonm          CGSO     = cgonm           
+CAPMOD  = 0              NQSMOD   = 0              XPART    = 1              
+CF      = 0              TLEV     = 1              TLEVC    = 1              
+XTI     = 3              N        = 1              HDIF     = hdifnm          
+LDIF    = 1.2E-07        RSH      = 4.5            RS       = 0              
+RD      = 0              ACM      = 12             )
*
*
*
***************************************************************
*                                                             *
*                 PMOS DEVICES MODEL                          *
*                                                             *
***************************************************************
*
*
.MODEL mpch2            PMOS   (                    LEVEL    = 49             
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+NLEV    = 3              AF       = 1.2            KF       = 1.5E-23      
+VERSION = 3.1            LMIN     = 3.5E-07        LMAX     = 2E-05          
+WMIN    = 3E-07          WMAX     = 1E-05          XL       = '3E-08+dxlm'    
+XW      = '0+dxwm'       TNOM     = 25             TOX      = toxpm           
+XJ      = 1E-07          NCH      = 1.210792E+17   LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4.195E-08      WINT     = 3.655E-09      MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    ='-0.2931907+dvthpm' LVTH0= 9.791687E-09   WVTH0    = -1.83327E-11   
+PVTH0   = 3.658534E-16   K1       = 0.3492984      LK1      = -1.05953E-08   
+WK1     = 6.416302E-09   PK1      = -1.89987E-15   K2       = 0.0221427      
+LK2     = -4.129551E-09  K3       = 0              DVT0     = 0              
+DVT1    = 0              DVT2     = 0              DVT0W    = 0              
+DVT1W   = 0              DVT2W    = 0              NLX      = 0              
+W0      = 0              K3B      = 0              VSAT     = 130000         
+UA      = 6.080643E-10   LUA      = 5.890098E-17   WUA      = -6.16036E-17   
+PUA     = -1.01757E-23   UB       = 7.951544E-19   LUB      = -3.0818E-27    
+WUB     = 2.103097E-27   PUB      = -4.19697E-32   UC       = -4.70335E-11   
+LUC     = 1.104313E-17   WUC      = -9.98158E-18   PUC      = -4.18793E-24   
+RDSW    = 1058.698       PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.0103461      LU0      = 2.006836E-10   
+WU0     = 3.179228E-10   PU0      = -9.41369E-17   A0       = 0.5513657      
+LA0     = 1.268983E-08   WA0      = 6.776283E-08   PA0      = -7.5286E-15    
+KETA    = 0.001708624    LKETA    = -1.369467E-09  WKETA    = -2.35822E-11   
+PKETA   = 4.706078E-16   A1       = 0              A2       = 0.4            
+AGS     = 0              B0       = 0              B1       = 0              
+VOFF    = -0.1237219     LVOFF    = 3.088751E-09   WVOFF    = -1.880989E-09  
+PVOFF   = 2.065847E-15   NFACTOR  = 0.83359        LNFACTOR = 6.507229E-08   
+CIT     = 0.0006374404   LCIT     = -2.71063E-11   CDSC     = 0              
+CDSCB   = 0              CDSCD    = 0              ETA0     = -1.856874E-05  
+LETA0   = 8.235632E-10   WETA0    = 4.936359E-12   PETA0    = -9.85097E-17   
+ETAB    = 1.961848E-05   LETAB    = -3.91508E-10   DSUB     = 0              
+PCLM    = 0.3735085      LPCLM    = 5.260143E-07   WPCLM    = 1.346721E-09   
+PPCLM   = -3.98763E-16   PDIBLC1  = 0              PDIBLC2  = -8.72513E-05   
+LPDIBLC2= 2.843244E-09   PDIBLCB  = -0.1971093     LPDIBLCB = 9.956941E-08   
+DROUT   = 0              PSCBE1   = 7.449946E+08   LPSCBE1  = 0.1070088      
+PSCBE2  = 1E-20          PVAG     = 0              DELTA    = 0.01           
+ALPHA0  = 5.08918E-07    BETA0    = 25.1292        KT1      = -0.230135      
+LKT1    = -9.352814E-09  WKT1     = 3.387447E-09   PKT1     = 1.723963E-15   
+KT2     = -0.0153        AT       = 10200          UTE      = -0.7146        
+UA1     = 2.062126E-09   LUA1     = -1.25084E-16   WUA1     = 2.492788E-17   
+PUA1    = -6.45977E-24   UB1      = -2.14967E-18   LUB1     = -7.70827E-26   
+WUB1    = 3.688063E-26   PUB1     = -1.09204E-32   UC1      = -8.36E-11      
+KT1L    = 0              PRT      = 0              HDIF     = hdifpm          
+LDIF    = 1.2E-07        RSH      = 3.5            RS       = 0              
+RD      = 0              CJ       = cjpm           MJ       = 0.479999       
+PB      = 0.9284534      CJSW     = cjswpm         MJSW     = 0.2568965      
+PBSW    = 0.9284534      CJSWG    = cjgatepm       MJSWG    = 0.2568965      
+PBSWG   = 0.9284534      CTA      = 0.0009438094   CTP      = 0.0003446883   
+PTA     = 0.001546029    PTP      = 0.001546029    CGDO     = cgopm           
+CGSO    = cgopm          ACM      = 12             CAPMOD   = 0              
+NQSMOD  = 0              XTI      = 3              N        = 1              
+XPART   = 1              CF       = 0              TLEV     = 1              
+TLEVC   = 1              JS       = 2E-06          JSW      = 2.5E-11        )
*
*
.ENDL MOSM2
*
.LIB MOSL2
*
*
*
***************************************************************
*                                                             *
*                                                             *
*              2.5V Native VT DEVICES MODEL                      *
*                                                             *
*                                                             *
*                                                             *
***************************************************************
*
**************************************************************************
*
*
***************************************************************
*                                                             *
*                 NMOS DEVICES MODEL                          *
*                                                             *
***************************************************************
*
*
.MODEL lnch2            NMOS   (                    LMIN     = 5E-07          
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1
+LMAX    = 2E-05          WMIN     = 3E-07          WMAX     = 1E-05          
+NLEV    = 3              AF       = 1.05           KF       = 9E-24      
+LEVEL   = 49             TNOM     = 25             XL       = '3E-08+dxll'    
+XW      = '0+dxwl'       VERSION  = 3.1            TOX      = toxnl           
+XJ      = 1E-07          NCH      = 6.5755E+16     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 3E-09          WINT     = 1.1E-08        MOBMOD   = 1              
+BINUNIT = 2              DWG      = 0              DWB      = 0              
+VTH0    ='0.05908338+dvthnl' LVTH0= 8.995678E-08   WVTH0    = 4.548919E-09   
+PVTH0   = -6.339592E-15  K1       = 0.2368916      LK1      = 5.874069E-08   
+WK1     = 2.805167E-08   PK1      = -6.292662E-15  K2       = -0.04969917    
+LK2     = -1.596654E-08  K3       = 0              DVT0     = 0              
+DVT1    = 0              DVT2     = 0              DVT0W    = 0              
+DVT1W   = 0              DVT2W    = 0              NLX      = 0              
+W0      = 0              K3B      = 0              VSAT     = 100274.1       
+LVSAT   = -0.005488758   WVSAT    = -5.37912E-05   PVSAT    = 1.077115E-09   
+UA      = 3.986577E-10   LUA      = -6.251743E-16  WUA      = 3.782929E-18   
+PUA     = 3.68281E-23    UB       = 7.05041E-19    LUB      = 8.440183E-25   
+WUB     = 3.300436E-26   PUB      = -9.971009E-32  UC       = 6.566635E-13   
+LUC     = 7.267299E-18   WUC      = -1.755864E-17  PUC      = 8.02143E-24    
+RDSW    = 194.6          PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.04670043     LU0      = -3.6412E-09    
+WU0     = -4.479355E-10  PU0      = 7.684161E-16   A0       = 0.07732753     
+LA0     = 2.244388E-07   WA0      = 1.189746E-07   PA0      = -9.186253E-14  
+KETA    = -0.02031646    LKETA    = 9.811214E-09   WKETA    = 2.588279E-09   
+PKETA   = -1.580189E-15  A1       = 0              A2       = 0.99           
+AGS     = -0.008829005   LAGS     = 4.626383E-09   WAGS     = 8.809558E-08   
+PAGS    = -4.616208E-14  B0       = 0              B1       = 0              
+VOFF    = -0.1020827     LVOFF    = -1.127505E-08  WVOFF    = -2.727438E-09  
+PVOFF   = 1.429178E-15   NFACTOR  = 3.531          LNFACTOR = -8.524289E-07  
+CIT     = -0.0001900631  LCIT     = 5.046712E-10   CDSC     = 0              
+CDSCB   = 0              CDSCD    = 0              ETA0     = 0.001994626    
+LETA0   = 1.076161E-10   ETAB     = -0.0007180619  LETAB    = -2.190255E-10  
+WETAB   = -4.30331E-12   PETAB    = 8.616921E-17   DSUB     = 0              
+PCLM    = 1.651722       LPCLM    = -3.671834E-07  WPCLM    = -4.755074E-09  
+PPCLM   = 9.530071E-14   PDIBLC1  = 0              PDIBLC2  = 0.06508577     
+LPDIBLC2= -6.752143E-09  WPDIBLC2 = 1.468266E-11   PPDIBLC2 = -7.69381E-18   
+PDIBLCB = -0.1921199     DROUT    = 0              PSCBE1   = 7.45E+08       
+PSCBE2  = 1E-20          PVAG     = 0              DELTA    = 0.01           
+ALPHA0  = 6.02E-07       BETA0    = 14.1707        KT1      = -0.2649244     
+LKT1    = 1.067869E-08   WKT1     = 2.880387E-09   PKT1     = -1.502729E-15  
+KT2     = -0.0189        AT       = 482.2387       UTE      = -1.3509        
+UA1     = 2.036667E-09   LUA1     = -2.173286E-17  WUA1     = -8.448352E-17  
+PUA1    = 1.71246E-23    UB1      = -1.47884E-18   LUB1     = -5.717676E-25  
+WUB1    = -3.033424E-25  PUB1     = 1.589514E-31   UC1      = -1.78E-11      
+KT1L    = 0              PRT      = 0              CJ       = cjnl            
+MJ      = 0.4492214      PB       = 0.98           CJSW     = cjswnl          
+MJSW    = 0.4115539      PBSW     = 0.98           CJSWG    = cjgatenl         
+MJSWG   = 0.4115539      PBSWG    = 0.98           CTA      = 0.00127985     
+CTP     = 0.0005246907   PTA      = 0.001291652    PTP      = 0.002125168    
+JS      = 2E-06          JSW      = 1.5E-10        CGDO     = cgonl           
+CGSO    = cgonl          CAPMOD   = 0              NQSMOD   = 0              
+XPART   = 1              CF       = 0              TLEV     = 1              
+TLEVC   = 1              XTI      = 3              N        = 1              
+HDIF    = hdifnl         LDIF     = 1.2E-07        RSH      = 4.5            
+RS      = 0              RD       = 0              ACM      = 12             )
*
.ENDL MOSL2
*
.LIB MOSZ2
*
*
*
***************************************************************
*                                                             *
*                                                             *
*               2.5V ZERO VT DEVICES MODEL                    *
*                                                             *
*                                                             *
*                                                             *
***************************************************************
*
**************************************************************************
*
*
***************************************************************
*                                                             *
*                 NMOS DEVICES MODEL                          *
*                                                             *
***************************************************************
*
*
.MODEL  znch2 NMOS (       LEVEL    = 49             
+CALCACM  = 1              SFVTFLAG = 0              VFBFLAG  = 1
+NLEV     = 3              AF       = 1.05           KF       = 7E-24      
+VERSION  = 3.1            LMIN     = 6E-07          LMAX     = 2.0E-05        
+WMIN     = 3E-07          WMAX     = 1.0E-05        XL       = '3E-8+dxlz'    
+XW       = '0+dxwz'       TNOM     = 25             TOX      = toxnz          
+XJ       = 1E-07          NCH      = 3.9562E+16     LLN      = 1              
+LWN      = 1              WLN      = 1              WWN      = 1              
+LINT     = 3.05E-08       WINT     = 2.4E-10        MOBMOD   = 1              
+BINUNIT  = 2              DWG      = 0              DWB      = 0              
+VTH0     = '-0.1489453+dvthnz' LVTH0 = 7.320649E-08 WVTH0    = 6.907929E-09   
+PVTH0    = -2.2967E-15    K1       = 0.1774437      LK1      = 2.402125E-08   
+WK1      = 5.595804E-09   PK1      = -1.25143E-15   K2       = 0.035514       
+LK2      = -1.051616E-08  K3       = 0              DVT0     = 0              
+DVT1     = 0              DVT2     = 0              DVT0W    = 0              
+DVT1W    = 0              DVT2W    = 0              NLX      = 0              
+W0       = 0              K3B      = 0              VSAT     = 80101.32       
+LVSAT    = -0.002023198   WVSAT    = -4.528082E-05  PVSAT    = 9.042118E-10   
+UA       = -4.63845E-10   LUA      = -8.29716E-17   WUA      = 9.780658E-19   
+PUA      = -1.9531E-23    UB       = 1.95411E-18    LUB      = 1.176107E-25   
+WUB      = 3.169659E-27   PUB      = -6.32948E-32   UC       = 3.527371E-11   
+LUC      = 1.597068E-18   WUC      = -1.06752E-17   PUC      = 2.771228E-24   
+RDSW     = 224            PRWB     = 0              PRWG     = 0              
+WR       = 1              U0       = 0.0367587      LU0      = 9.062929E-10   
+WU0      = 1.084428E-11   PU0      = -2.16549E-16   A0       = 0.2231806      
+LA0      = 8.228844E-08   WA0      = 4.141416E-08   PA0      = -2.35647E-14   
+KETA     = -0.0152278     LKETA    = 3.712762E-10   WKETA    = 2.153163E-09   
+PKETA    = -1.22937E-15   A1       = 0              A2       = 0.99           
+AGS      = 0              B0       = 0              B1       = 0              
+VOFF     = -0.2048495     LVOFF    = -2.810627E-09  WVOFF    = -1.218458E-08  
+PVOFF    = 1.750193E-15   NFACTOR  = 12.045925      LNFACTOR = -3.384265E-06  
+CIT      = -0.003274056   LCIT     = 1.534198E-09   CDSC     = 0              
+CDSCB    = 0              CDSCD    = 0              ETA0     = 0.001373672    
+LETA0    = 3.121721E-09   ETAB     = -0.0002985057  LETAB    = 1.698497E-10   
+DSUB     = 0              PCLM     = 0.1733506      LPCLM    = 1.055352E-06   
+PDIBLC1  = 0              PDIBLC2  = 0.006097592    LPDIBLC2 = 2.244665E-09   
+WPDIBLC2 = -4.61865E-11   PPDIBLC2 = 9.22296E-16    PDIBLCB  = 0.1921199      
+DROUT    = 0              PSCBE1   = 7.45E+08       PSCBE2   = 1E-20          
+PVAG     = 0              DELTA    = 0.01           ALPHA0   = 5.38E-07       
+BETA0    = 13.8343        KT1      = -0.3812491     LKT1     = 1.906522E-08   
+WKT1     = 1.004556E-08   PKT1     = -2.04858E-15   KT2      = -0.0403997     
+LKT2     = -6.34789E-12   WKT2     = -3.15415E-12   PKT2     = 7.277E-17      
+AT       = 8440.293       LAT      = -2.897996E-06  WAT      = -1.525497E-06  
+PAT      = 8.68008E-13    UTE      = -1.6741756     LUTE     = 6.409758E-10   
+WUTE     = 4.976588E-08   PUTE     = -6.6301E-15    UA1      = 1.070159E-09   
+LUA1     = 6.093642E-17   UB1      = -2.28452E-18   LUB1     = 1.236433E-25   
+WUB1     = 6.508547E-26   PUB1     = -3.70336E-32   UC1      = -1.44536E-10   
+LUC1     = 4.609683E-17   WUC1     = 2.425363E-17   PUC1     = -1.81982E-23   
+KT1L     = 0              PRT      = 0              HDIF     = hdifnz         
+LDIF     = 1.2E-07        RSH      = 4.5            RS       = 0              
+RD       = 0              CJ       = cjnz           MJ       = 0.5273578      
+PB       = 0.99           CJSW     = cjswnz         MJSW     = 0.3420729      
+PBSW     = 0.99           CJSWG    = cjgatenz       MJSWG    = 0.3420729      
+PBSWG    = 0.99           CTA      = 0.001192692    CTP      = 0.0001364908   
+PTA      = 0.001626999    PTP      = 0.001626999    CGDO     = cgonz          
+CGSO     = cgonz          ACM      = 12             CAPMOD   = 0              
+NQSMOD   = 0              XTI      = 3              N        = 1              
+XPART    = 1              CF       = 0              TLEV     = 1              
+TLEVC    = 1              JS       = 2E-06          JSW      = 1.5E-10        )
*
*
*
***************************************************************
*                                                             *
*                 PMOS DEVICES MODEL                          *
*                                                             *
***************************************************************
*
*
.MODEL  zpch2 PMOS (       LEVEL    = 49             
+CALCACM  = 1              SFVTFLAG = 0              VFBFLAG  = 1
+NLEV     = 3              AF       = 1.15           KF       = 1.5E-23      
+VERSION  = 3.1            LMIN     = 6E-07          LMAX     = 2.0E-05        
+WMIN     = 3E-07          WMAX     = 1.0E-05        XL       = '3E-8+dxlz'    
+XW       = '0+dxwz'       TNOM     = 25             TOX      = toxpz          
+XJ       = 1E-07          NCH      = 4.5182E+16     LLN      = 1              
+LWN      = 1              WLN      = 1              WWN      = 1              
+LINT     = 2.03E-08       WINT     = 5E-11          MOBMOD   = 1              
+BINUNIT  = 2              DWG      = 0              DWB      = 0              
+VTH0     = '-0.0572677+dvthpz' LVTH0 = 2.191056E-08 WVTH0    = 2.257373E-10   
+PVTH0    = -1.01919E-14   K1       = 0.2412547      LK1      = -6.581959E-09  
+WK1      = 3.751103E-09   PK1      = -1.09652E-16   K2       = 0.0279963      
+K3       = 0              DVT0     = 0              DVT1     = 0              
+DVT2     = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W    = 0              NLX      = 0              W0       = 0              
+K3B      = 0              VSAT     = 147997.9       LVSAT    = 4.190417E-05   
+UA       = 4.075928E-10   LUA      = 6.87811E-19    WUA      = -8.60792E-17   
+PUA      = -3.84162E-24   UB       = 1.123257E-18   LUB      = -6.08145E-26   
+WUB      = -1.02411E-25   PUB      = 5.19767E-33    UC       = -4.02662E-11   
+LUC      = 1.27784E-17    WUC      = -7.91116E-18   PUC      = -6.37662E-24   
+RDSW     = 1041.4         PRWB     = 0              PRWG     = 0              
+WR       = 1              U0       = 0.010286       LU0      = 9.659422E-12   
+WU0      = 4.831078E-12   PU0      = -9.65703E-17   A0       = 0.1832663      
+LA0      = 1.438277E-10   WA0      = 1.573355E-07   PA0      = -1.43827E-15   
+KETA     = -0.005041675   LKETA    = -1.04685E-08   WKETA    = 4.236008E-09   
+PKETA    = -4.45753E-16   A1       = 0              A2       = 0.4            
+AGS      = 0              B0       = 0              B1       = 0              
+VOFF     = -0.1675561     LVOFF    = 1.13613E-08    WVOFF    = -1.558262E-08  
+PVOFF    = 9.184397E-15   NFACTOR  = 1.60162        LNFACTOR = -4.627744E-08  
+CIT      = 0.0003612302   CDSC     = 0              CDSCB    = 0              
+CDSCD    = 0              ETA0     = 9.156959E-05   LETA0    = 8.856134E-11   
+WETA0    = 4.539854E-13   PETA0    = -9.07494E-18   ETAB     = -5.218461E-06  
+LETAB    = -1.07574E-10   WETAB    = -1.62076E-12   PETAB    = 3.239796E-17   
+DSUB     = 0              PCLM     = 1.4316454      LPCLM    = 1.050368E-07   
+PDIBLC1  = 0              PDIBLC2  = -0.0005854946  LPDIBLC2 = 1.296502E-08   
+WPDIBLC2 = 5.987577E-11   PPDIBLC2 = -1.19687E-15   PDIBLCB  = -0.075308      
+DROUT    = 0              PSCBE1   = 7.449892E+08   LPSCBE1  = 0.2162207      
+PSCBE2   = 1E-20          PVAG     = 0              DELTA    = 0.01           
+ALPHA0   = 4.18934E-08    BETA0    = 19.7481        KT1      = -0.3161627     
+LKT1     = 2.287802E-08   WKT1     = 9.993981E-09   PKT1     = -1.62227E-14   
+KT2      = -0.0257        AT       = 10000          UTE      = -1.1086        
+UA1      = 7.25223E-10    LUA1     = -3.49619E-16   WUA1     = -1.77842E-16   
+PUA1     = 1.048508E-22   UB1      = -1.29237E-18   LUB1     = -1.87147E-25   
+WUB1     = 2.209456E-25   PUB1     = -7.1913E-32    UC1      = 1.538803E-11   
+LUC1     = -2.56318E-17   WUC1     = -1.30421E-17   PUC1     = 7.686992E-24   
+KT1L     = 0              PRT      = 0              HDIF     = hdifpz         
+LDIF     = 1.2E-07        RSH      = 3.5            RS       = 0              
+RD       = 0              CJ       = cjpz           MJ       = 0.4561697      
+PB       = 0.8415575      CJSW     = cjswpz         MJSW     = 0.2555894      
+PBSW     = 0.8415575      CJSWG    = cjgatepz       MJSWG    = 0.2555894      
+PBSWG    = 0.8415575      CTA      = 0.0009653663   CTP      = 0.0002566444   
+PTA      = 0.001476399    PTP      = 0.001476399    CGDO     = cgopz          
+CGSO     = cgopz          ACM      = 12             CAPMOD   = 0              
+NQSMOD   = 0              XTI      = 3              N        = 1              
+XPART    = 1              CF       = 0              TLEV     = 1              
+TLEVC    = 1              JS       = 2E-06          JSW      = 2.5E-11        )
*
.ENDL MOSZ2
*
***************************************************************
*                                                             *
*                                                             *
*               3.3V NATIVE VT DEVICES MODEL                  *
*                                                             *
*                                                             *
*                                                             *
***************************************************************
*
**************************************************************************
*
*
***************************************************************
*                                                             *
*                 NMOS DEVICES MODEL                          *
*                                                             *
***************************************************************
*
.LIB MOSN3
.MODEL nnch3          NMOS   (                     LMIN    = 1.2E-06       
+CALCACM = 1              SFVTFLAG= 0              VFBFLAG = 1
+LMAX    = 2.0E-05        WMIN    = 3E-07          WMAX    = 1.0E-05         
+LEVEL   = 49             TNOM    = 25             VERSION = 3.1            
+NLEV    = 3              AF      = 0.95           KF      = 6E-24      
+TOX     = toxz3          XJ      = 1E-07          NCH     = 1.7748E+15     
+LLN     = 1              LWN     = 1              WLN     = 1              
+WWN     = 1              LINT    = 4.5E-08        LL      = 0              
+LW      = 0              LWL     = 0              WINT    = 3.97E-09       
+WL      = 0              WW      = 0              WWL     = 0              
+MOBMOD  = 1              BINUNIT = 2              XL      = '3E-8 + dxlz3 '
+XW      = '0 + dxwz3 '   DWG     = 0              DWB     = 0              
+VTH0 = '-0.09619901 + dvthz3 ' LVTH0 = -2.6160807E-8 WVTH0 = 1.2363397E-08    
+PVTH0   = -2.4517542E-15 K1      = 0.09781694     LK1     = 2.572616E-08   
+WK1     = 4.99131E-08    PK1     = -3.19997E-14   K2      = -5.907628E-03  
+LK2     = -1.737353E-08  WK2     = 1.725382E-09   PK2     = 5.074112E-15   
+K3      = 0              DVT0    = 0              DVT1    = 0              
+DVT2    = 0              DVT0W   = 0              DVT1W   = 0              
+DVT2W   = 0              NLX     = 0              W0      = 0              
+K3B     = 0              VSAT    = 110992.2       LVSAT   = 9.128914E-03   
+UA      = 8.882777E-11   LUA     = 1.786647E-16   WUA     = 6.822393E-17   
+PUA     = -3.500847E-23  UB      = 8.170988E-19   LUB     = 5.345582E-25   
+WUB     = 7.946532E-27   PUB     = -1.243848E-31  UC      = -2.475334E-11  
+LUC     = 1.839471E-17   WUC     = -4.370195E-18  PUC     = -6.774047E-24  
+RDSW    = 318.6428       PRWB    = 0              PRWG    = 0              
+WR      = 0.7708861      U0      = 0.04114679     LU0     = 5.590361E-09   
+WU0     = 1.41316E-10    PU0     = -1.483413E-16  A0      = 1.086131       
+LA0     = 6.41719E-07    WA0     = 2.316547E-08   PA0     = -1.259745E-13  
+KETA    = -0.02741725    LKETA   = 5.676418E-08   WKETA   = 3.231136E-09   
+PKETA   = -1.113352E-14  A1      = 0              A2      = 0.9970777      
+LA2     = -1.62538E-07   WA2     = -4.634341E-08  PA2     = 3.819997E-14   
+AGS     = 0.4493652      LAGS    = -1.251935E-06  WAGS    = -5.072293E-08  
+PAGS    = 2.991209E-13   B0      = 0              B1      = 0              
+VOFF    = -0.1521513     LVOFF   = 2.504013E-09   WVOFF   = -2.101192E-08  
+PVOFF   = 2.585321E-14   NFACTOR = 1.713607       LNFACTOR= -2.033507E-07  
+WNFACTOR= -2.36196E-07   PNFACTOR= 1.819038E-12   CIT     = 1.011177E-03   
+LCIT    = -1.274212E-11  WCIT    = -1.116839E-10  PCIT    = 1.273197E-16   
+CDSC    = 0              CDSCB   = 0              CDSCD   = 0              
+ETA0    = 3.571546E-05   LETA0   = 7.564249E-09   WETA0   = 1.018624E-11   
+PETA0   = -1.959701E-15  ETAB    = 3.179808E-11   LETAB   = -3.62498E-17   
+WETAB   = -9.286946E-18  PETAB   = 1.058712E-23   DSUB    = 0              
+PCLM    = 9.361721       LPCLM   = -2.693813E-06  WPCLM   = -2.420531E-06  
+PPCLM   = 1.437735E-12   PDIBLC1 = 0              PDIBLC2 = 3.860079E-05   
+LPDIBLC2= 1.917029E-08   WPDIBLC2= -1.857392E-11  PPDIBLC2= 3.703553E-16   
+PDIBLCB = 0              DROUT   = 0              PSCBE1  = 5.733E+08      
+PSCBE2  = 3.327823E-06   LPSCBE2 = -1.243994E-12  PVAG    = 0.1141585      
+LPVAG   = 7.502969E-06   WPVAG   = 8.746922E-08   PPVAG   = -2.329041E-12  
+DELTA   = 7.263340E-04   LDELTA  = 1.109979E-09   ALPHA0  = 4.8210560E-09  
+BETA0   = 8.9437500      KT1     = -0.4171169     LKT1    = -2.486638E-08  
+WKT1    = -2.467402E-09  PKT1    = 9.140385E-15   KT2     = -0.02303174    
+LKT2    = -8.197601E-09  WKT2    = 5.68951E-09    PKT2    = -1.027222E-14  
+AT      = 1.000000E+04   UTE     = -1.85497       LUTE    = -1.316658E-07  
+WUTE    = -5.780316E-08  PUTE    = 1.286112E-13   UA1     = -1.095568E-14  
+LUA1    = 2.184684E-19   WUA1    = 1.094763E-19   PUA1    = -2.182955E-24  
+UB1     = 1.376538E-19   LUB1    = -2.043563E-24  WUB1    = -6.491686E-25  
+PUB1    = 8.389219E-31   UC1     = 6.946249E-12   LUC1    = -8.948461E-18  
+WUC1    = -2.96649E-17   PUC1    = 4.410718E-23   KT1L    = 0              
+PRT     = 0              ACM     = 12             HDIF    = hdifz3        
+LDIF    = 1.2E-08        RSH     = 4.5            RS      = 0              
+RD      = 0              CJ      = cjz3           MJ      = 0.3911789      
+PB      = 0.5662505      CJSW    = cjswz3         MJSW    = 0.1137511      
+PBSW    = 0.5662505      CJSWG   = cjgatez3       MJSWG   = 0.1137511      
+PBSWG   = 0.5662505      CTA     = 2.794692E-3    CTP     = 6.051099E-4   
+PTA     = 2.659072E-3    PTP     = 2.659072E-3    CGDO    = cgoz3       
+CGSO    = cgoz3          CAPMOD  = 0              NQSMOD  = 0              
+XTI     = 3              N       = 1              XPART   = 1              
+CF      = 0              TLEV    = 1              TLEVC   = 1              
+JS      = 1E-06          JSW     = 5E-11           )
*
*
*
.ENDL MOSN3
*
.LIB BIP
*
***************************************************************
*            MODEL OF P+/NW/PSUB VERTICAL BIPOLAR             *
*                 EMITTER AREA :  10 X 10 UM^2                *
***************************************************************
*
.MODEL pnp10 PNP (                                  LEVEL  = 1                  
+ BF     = 1.79            NF     = 0.95513         ISE    = 3.7315E-18         
+ NE     = 1.069           IS     = 3.7315E-18      RB     = 140.9375822        
+ IRB    = 1.806256E-4     RBM    = 0.1             RE     = 3.717704           
+ IKF    = 2.568E-3        NKF    = 0.5             VAF    = 210.8833929        
+ BR     = 0.0101          NR     = 0.94            ISC    = 3.7315E-18         
+ NC     = 1.1616142       RC     = 21.08           IKR    = 1E-4               
+ VAR    = 17              XTI    = 3               EG     = 1.18               
+ XTB    = 0               TRB1   = 6.25612E-4      TIRB1  = 1.052303E-7        
+ TRM1   = 9.44068E-6      TRE1   = -1.82691E-4     TIKF1  = -3.845646E-3       
+ TIKR1  = -3.925072E-3    TRC1   = 0               TBR1   = 1.2E-4             
+ TVAF1  = -6.950157E-5    TBF1   = 4E-3            TNC1   = 3.017315E-4        
+ TNR1   = -1.50125E-4     TNF1   = -2.205635E-4    TNE1   = 1E-3               
+ CJE    = 1.181769E-13    VJE    = 0.8661689       MJE    = 0.3873499          
+ FC     = 0               CJC    = 6.170502E-14    VJC    = 0.6454517          
+ MJC    = 0.3487117       TLEVC  = 1               CTE    = 9.950871E-4        
+ CTC    = 2.347422E-3     TVJE   = 1.685132E-3     TVJC   = 2.929049E-3        
+ TREF   = 25              SUBS   = 1               )                           
***************************************************************
*            MODEL OF P+/NW/PSUB VERTICAL BIPOLAR             *
*                 EMITTER AREA :  5 X 5 UM^2                  *
***************************************************************
*                                                                               
.MODEL pnp5 PNP (                                   LEVEL  = 1                  
+ BF     = 1.75            NF     = 0.95513         ISE    = 1E-18              
+ NE     = 1.069           IS     = 1E-18           RB     = 210.9375822        
+ IRB    = 1.806256E-4     RBM    = 0.1             RE     = 3.717704           
+ IKF    = 1.268E-3        NKF    = 0.5             VAF    = 210.8833929        
+ BR     = 4.3E-3          NR     = 0.935           ISC    = 1E-18              
+ NC     = 1               RC     = 21.08           IKR    = 1E-4               
+ VAR    = 17              XTI    = 3               EG     = 1.18               
+ XTB    = 0               TRB1   = 6.25612E-4      TIRB1  = 1.052303E-7        
+ TRM1   = 9.44068E-6      TRE1   = -1.82691E-4     TIKF1  = -3.845646E-3       
+ TIKR1  = -3.925072E-3    TRC1   = 0               TBR1   = 1.2E-4             
+ TVAF1  = -6.950157E-5    TBF1   = 4E-3            TNC1   = 3.017315E-4        
+ TNR1   = -1.50125E-4     TNF1   = -2.205635E-4    TNE1   = 1E-3               
+ CJE    = 1.181769E-13    VJE    = 0.8661689       MJE    = 0.3873499          
+ FC     = 0               CJC    = 6.170502E-14    VJC    = 0.6454517          
+ MJC    = 0.3487117       TLEVC  = 1               CTE    = 9.950871E-4        
+ CTC    = 2.347422E-3     TVJE   = 1.685132E-3     TVJC   = 2.929049E-3        
+ TREF   = 25              SUBS   = 1               )                           
***************************************************************
*            MODEL OF P+/NW/PSUB VERTICAL BIPOLAR             *
*                 EMITTER AREA :  2 X 2 UM^2                  *
***************************************************************
*                                                                               
.MODEL pnp2 PNP (                                   LEVEL  = 1                  
+ BF     = 1.64            NF     = 0.95513         ISE    = 2.3E-19            
+ NE     = 1.069           IS     = 2.3E-19         RB     = 420.9375822        
+ IRB    = 1.806256E-4     RBM    = 0.1             RE     = 3.717704           
+ IKF    = 5E-4            NKF    = 0.5             VAF    = 210.8833929        
+ BR     = 1.36E-3         NR     = 0.923           ISC    = 2.3E-19            
+ NC     = 1               RC     = 21.08           IKR    = 1E-4               
+ VAR    = 15              XTI    = 3               EG     = 1.18               
+ XTB    = 0               TRB1   = 2.25612E-4      TIRB1  = 1.052303E-7        
+ TRM1   = 9.44068E-6      TRE1   = -1.82691E-4     TIKF1  = 4E-4               
+ TIKR1  = -3.925072E-3    TRC1   = 0               TBR1   = 1.2E-4             
+ TVAF1  = -6.950157E-5    TBF1   = 4.4E-3          TNC1   = 3.017315E-4        
+ TNR1   = -1.50125E-4     TNF1   = -1.205635E-4    TNE1   = 1E-3               
+ CJE    = 1.181769E-13    VJE    = 0.8661689       MJE    = 0.3873499          
+ FC     = 0               CJC    = 6.170502E-14    VJC    = 0.6454517          
+ MJC    = 0.3487117       TLEVC  = 1               CTE    = 9.950871E-4        
+ CTC    = 2.347422E-3     TVJE   = 1.685132E-3     TVJC   = 2.929049E-3        
+ TREF   = 25              SUBS   = 1               )                           
*
.ENDL BIP
*
.LIB DIO                                                                        
*
***************************************************************
*                      MODEL OF N+/PW DIODE                   *
***************************************************************
*
.MODEL NDIO D (                                     LEVEL  = 3                  
+ IS     = 1.32577E-5      RS     = 1.679514E-7     N      = 1.3414034          
+ BV     = 7.4             IBV    = 0.01           IK      = 1E20               
+IKR     = 1E10           JSW     = 1.1029E-10     AREA    = 7.5E-8             
+ PJ     = 1.1E-3          CJ     = 1.836615E-3    PB      = 0.9597901          
+ MJ     = 0.4708251       CJSW   = 4.234822E-10    PHP    = 0.9597901          
+ MJSW   = 0.379613        TLEV   = 1               EG     = 1.16               
+ XTI    = 3               TCV    = -6E-4           TRS    = 2.2236E-3          
+ TLEVC  = 1               CTA    = 7.391288E-4     CTP    = 9.081566E-4        
+ TPB    = 1.167715E-3     TPHP   = 1.167715E-3     TREF   = 25                 
+ FC     = 0               FCS    = 0           )                               
*                                                                               
***************************************************************
*                      MODEL OF P+/NW DIODE                   *
***************************************************************
*                                                        
.MODEL PDIO D (                                     LEVEL  = 3                  
+ IS     = 1E-6            RS     = 1.625915E-7     N      = 1.2113671          
+ BV     = 7.2             IBV    = 1E-3           IK      = 1E20               
+IKR     = 1E10           JSW     = 1.09E-10       AREA    = 7.5E-8             
+ PJ     = 1.1E-3          CJ     = 1.833935E-3    PB      = 0.9522272          
+ MJ     = 0.4746122       CJSW   = 3.472876E-10    PHP    = 0.9522272          
+ MJSW   = 0.3296904       TLEV   = 1               EG     = 1.172              
+ XTI    = 3               TCV    = -8E-4           TRS    = 3.5943E-3          
+ TLEVC  = 1               CTA    = 8.154354E-4     CTP    = 6.079875E-4        
+ TPB    = 1.40666E-3      TPHP   = 1.610754E-3     TREF   = 25                 
+ FC     = 0               FCS    = 0           )                               
*
***************************************************************
*                      MODEL OF NW/Psub DIODE                 *
***************************************************************
*                                      
.MODEL NWDIO D  (                                   LEVEL  = 3                  
+ IS     = 4.1296E-6       RS     = 1.737415E-7     N      = 1.2889996          
+ BV     = 18.6            IBV    = 0.03           IK      = 1E20               
+IKR     = 1E10           JSW     = 1.4088E-10     AREA    = 7.56614E-8         
+ PJ     = 1.1048E-3       CJ     = 1.153705E-4    PB      = 0.7147275          
+ MJ     = 0.4204926       CJSW   = 4.222814E-10    PHP    = 0.7147275          
+ MJSW   = 0.2589437       TLEV   = 1               EG     = 1.17               
+ XTI    = 3               TCV    = -8E-4           TRS    = 2.78E-3            
+ TLEVC  = 1               CTA    = 2.875348E-3     CTP    = 1.629489E-3        
+ TPB    = 3.402024E-3     TPHP   = 3.402024E-3     TREF   = 25                 
+ FC     = 0               FCS    = 0           )                               
*                                                                               
.ENDL DIO                                                                       
                                                        
*
*
*
**************************************************************************
*
*   resistor models
*
**************************************************************************
*
.LIB RES
******************************************************
.subckt rppo1rpo n1 n2 l=length w=width
.param rc=6.1 nc=2
.param rsh=160 dl=0.5u dw=0.02u pt='temper' ptcp1=7.64e-4 ptcp2=0 pvcp1=5.52e-4 pvcp2=0
.param rint=137.7u ptcx1=-8.57e-4 ptcx2=0 pvcx1=0.916 pvcx2=0
.param tfacx='1.0+ptcx1*(pt-25.0)+ptcx2*(pt-25)*(pt-25)'
.param tfacp='1.0+ptcp1*(pt-25.0)+ptcp2*(pt-25)*(pt-25)'
rcon1 n1 1 'rc/nc'
rend1 1 3  'rint/(w-dw)*tfacx*(1.0+pvcx1*abs(v(1,3))+pvcx2*v(1,3)*v(1,3))'
rp 3 4  'rsh*(l-dl)/(w-dw)*tfacp*(1.0+pvcp1*abs(v(3,4))+pvcp2*v(3,4)*v(3,4))'
rend2 4 2  'rint/(w-dw)*tfacx*(1.0+pvcx1*abs(v(4,2))+pvcx2*v(4,2)*v(4,2))'
rcon2 2 n2 'rc/nc'
.ends rppo1rpo




.subckt rppo1w n1 n2 l=length w=width
.param rsh=5.0 dw=-0.03u ptc1=3.04E-03 ptc2=-2.61E-07 pvc1=5.66E-03 pvc2=1.08E-02 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rppo1w

.subckt rppo1 n1 n2 l=length w=width
.param rsh=5.0 dw=-0.03u ptc1=3.04E-03 ptc2=-2.61E-07 pvc1=5.66E-03 pvc2=1.08E-02 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rppo1





***************************************************
.subckt rnpo1rpo n1 n2 l=length w=width
.param rc=7 nc=2
.param rsh=180 dl=0.2u dw=0.04u pt='temper' ptcp1=-6.2e-4 ptcp2=0 pvcp1=7.02e-3 pvcp2=-2e-3
.param rint=37.1u ptcx1=-4.2e-4 ptcx2=0 pvcx1=-5.24 pvcx2=0
.param tfacx='1.0+ptcx1*(pt-25.0)+ptcx2*(pt-25)*(pt-25)'
.param tfacp='1.0+ptcp1*(pt-25.0)+ptcp2*(pt-25)*(pt-25)'
rcon1 n1 1 'rc/nc'
rend1 1 3  'rint/(w-dw)*tfacx*(1.0+pvcx1*abs(v(1,3))+pvcx2*v(1,3)*v(1,3))'
rp 3 4  'rsh*(l-dl)/(w-dw)*tfacp*(1.0+pvcp1*abs(v(3,4))+pvcp2*v(3,4)*v(3,4))'
rend2 4 2  'rint/(w-dw)*tfacx*(1.0+pvcx1*abs(v(4,2))+pvcx2*v(4,2)*v(4,2))'
rcon2 2 n2 'rc/nc'
.ends rnpo1rpo

***************************************************





.subckt rnpo1w n1 n2 l=length w=width
.param rsh=5.0 dw=-0.03u ptc1=3.15E-03 ptc2=8.52E-07 pvc1=5.37E-03 pvc2=1.06E-02 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rnpo1w

.subckt rnpo1 n1 n2 l=length w=width
.param rsh=5.3 dw=-0.03u ptc1=3.15E-03 ptc2=8.52E-07 pvc1=5.37E-03 pvc2=1.06E-02 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rnpo1

.subckt rnodw n1 n2 l=length w=width
.param rsh=5.0 dw=0.02u ptc1=2.98E-03 ptc2=1.36E-08 pvc1=3.30E-03 pvc2=1.30E-03 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rnodw

.subckt rnod n1 n2 l=length w=width
.param rsh=10.5 dw=0.02u ptc1=2.98E-03 ptc2=1.36E-08 pvc1=3.30E-03 pvc2=1.30E-03 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rnod

.subckt rnodrpo n1 n2 l=length w=width
.param rsh=61 dw=0.01u ptc1=1.45E-03 ptc2=1.43E-07 pvc1=1.60E-03 pvc2=-9.03E-05 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rnodrpo

.subckt rpodw n1 n2 l=length w=width
.param rsh=5.0 dw=0.02u ptc1=3.20E-03 ptc2=-2.82E-07 pvc1=-4.15E-04 pvc2=3.31E-03 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rpodw

.subckt rpod n1 n2 l=length w=width
.param rsh=5.0 dw=0.02u ptc1=3.20E-03 ptc2=-2.82E-07 pvc1=-4.15E-04 pvc2=3.31E-03 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rpod

.subckt rpodrpo n1 n2 l=length w=width
.param rsh=145 dw=0.01u ptc1=1.41E-03 ptc2=9.52E-07 pvc1=2.02E-03 pvc2=-1.54E-04 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rpodrpo

.subckt rnwod n1 n2 l=length w=width
.param rsh=580 dw=0.15u ptc1=2.78E-03 ptc2=8.11E-06 pvc1=0 pvc2=0 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rnwod

.subckt rnwsti n1 n2 l=length w=width
.param rsh=1100 dw=0.24u ptc1=3.60E-03 ptc2=1.12E-05 pvc1=9.00E-03 pvc2=-7.16E-04 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rnwsti

.subckt rnrpoesd n1 n2 l=length w=width
.param rsh=60 dw=0.01u ptc1=1.25E-03 ptc2=2.54E-06 pvc1=0 pvc2=0 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rnrpoesd

.subckt rm1 n1 n2 l=length w=width
.param rsh=0.076 dw=-0.02u ptc1=3.27E-03 ptc2=2.38E-07 pvc1=0 pvc2=0 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rm1

.subckt rm2 n1 n2 l=length w=width
.param rsh=0.076 dw=-0.02u ptc1=3.29E-03 ptc2=2.60E-07 pvc1=0 pvc2=0 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rm2

.subckt rm3 n1 n2 l=length w=width
.param rsh=0.076 dw=-0.02u ptc1=3.34E-03 ptc2=0 pvc1=0 pvc2=0 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rm3

.subckt rm4 n1 n2 l=length w=width
.param rsh=0.076 dw=-0.02u ptc1=3.18E-03 ptc2=0 pvc1=0 pvc2=0 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rm4

.subckt rm5 n1 n2 l=length w=width
.param rsh=0.041 dw=-0.02u ptc1=3.14E-03 ptc2=2.71E-06 pvc1=0 pvc2=0 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rm5


.ENDL RES

