import '../css/main.scss';

const appReadyEvent = new Event('app:ready');

const removeFallbackStyles = () => {
  const fallback = document.getElementById('bundle-css');
  if (fallback && fallback.parentElement) {
    fallback.parentElement.removeChild(fallback);
  }
};

if (import.meta.hot) {
  removeFallbackStyles();
  import.meta.hot.on('vite:afterUpdate', removeFallbackStyles);
}

window.dispatchEvent(appReadyEvent);
