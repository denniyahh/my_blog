import '../css/main.scss';

const appReadyEvent = new Event('app:ready');

window.dispatchEvent(appReadyEvent);
