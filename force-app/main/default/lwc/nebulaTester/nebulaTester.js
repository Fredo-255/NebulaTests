import { LightningElement } from 'lwc';

export default class NebulaTester extends LightningElement {

    handleClick() {
        const logger = this.template.querySelector("c-logger");
        logger.info('Click');
        logger.saveLog();
    }


}