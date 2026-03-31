const INSTALLER_URL = 'https://raw.githubusercontent.com/greppilot/cli/main/installer.sh';
const CLI_URL = 'https://raw.githubusercontent.com/greppilot/cli/main/greppilot';

export default {
  async fetch(request) {
    const url = new URL(request.url);
    const target = url.pathname === '/cli' ? CLI_URL : INSTALLER_URL;
    const res = await fetch(target);
    return new Response(res.body, {
      headers: { 'Content-Type': 'text/plain; charset=utf-8', 'Cache-Control': 'no-cache' },
    });
  },
};
