import exp from 'constants';
import Logger from './logger';

export class AdianteLog{

    private static startingText: string = 
    `#    ##        ###     ##                         ## #
     #   ####        ##                                ## #
     #  ##  ##       ##    ###      ####    #####     #####    #### #
     #  ##  ##    #####     ##         ##   ##  ##     ##     ##  ## #
     #  ######   ##  ##     ##      #####   ##  ##     ##     ###### #
     #  ##  ##   ##  ##     ##     ##  ##   ##  ##     ## ##  ## #
     #  ##  ##    ######   ####     #####   ##  ##      ###    ##### #`;

 
    public static logApplicationStartingInit() {
        Logger.info('----------------------------------------------------------------------------------');
        Logger.info(AdianteLog.startingText);
        Logger.info("starting application:");
        Logger.info('----------------------------------------------------------------------------------');
        Logger.info('Loading server config');
    }

    public static logApplicationStartingEnd(port:string) {
        console.log('Server is up and running on port:'+port);
        Logger.info('Server is up and running on port:'+port);
        Logger.info('----------------------------------------------------------------------------------');
    }
 }
 export default AdianteLog
 
