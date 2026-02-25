# 🔥 nusaibSec Recon Automator
**From Manual to Fully Automated: The Ultimate Bug Bounty Recon Script**

Stop wasting hours running individual commands and organizing text files! **nusaibSec Recon Automator** converts a massive, tedious manual Bug Bounty reconnaissance methodology into a single, highly optimized Bash script. Just run the script, and it will do all the heavy lifting, creating a neatly organized folder with all the hackable data right in front of you.

---

## 🚀 Features & The 7-Phase Pipeline

This script chains together the best tools in the industry to create a flawless pipeline:

* **Phase 1: Lightning-Fast Passive Mapping** - Gathers thousands of subdomains passively using APIs (Subfinder, Assetfinder, Chaos).
* **Phase 2: DNS Resolution** - Filters out the noise and drops offline assets using `dnsx` to keep only the "Alive" targets.
* **Phase 3: Infrastructure & Port Analysis** - Blazing-fast top 100 port scan with `naabu`, dynamically triggering `nmap` (-sV -sC) on discovered open ports.
* **Phase 4: Web Probing & Vuln Scanning** - Probes for live web apps with `httpx` and hunts for quick-win Subdomain Takeovers using `subzy`.
* **Phase 5: Deep Crawling & JS Extraction** - Launches `katana` to deeply crawl websites, automatically extracting `.js` files and sensitive extensions (`.xml`, `.bak`, `.sql`, etc.).
* **Phase 6: Automated Parameter Mining** - Cleans duplicate URLs with `uro` and feeds them into `gxss` to hand you a final list of reflected parameters primed for XSS and SQLi testing.
* **Phase 7: The Background Heavy Lifters** - Secretly runs heavy, time-consuming tools (`asnmap`, `amass`, `oneforall`) in the background while you hack the fast results.

---

## 🛠️ The Arsenal (Prerequisites)

Before running the script, ensure you have the following tools installed and accessible in your system's `$PATH`:

* Subfinder, Assetfinder, Chaos, DNSX, Anew, Naabu, Nmap, HTTPX, Subzy, Katana, Uro, Gxss, ASNMap, Amass, OneForAll.

---

## 💻 Installation & Usage

**1. Clone the repository:**
```bash
git clone https://github.com/nusaibnull/Recon-Automator
### 💻 Execution

```bash
chmod +x recon.sh
./recon.sh target.com

target.com_recon/
├── passive_subs.txt          # All passively discovered subdomains
├── resolved_subs.txt         # Only ALIVE subdomains
├── open_ports.txt            # Live ports discovered by Naabu
├── nmap_scan_results.txt     # Deep service scan results
├── live_webapps.txt          # Live HTTP/HTTPS web applications
├── potential_takeovers.txt   # Subdomain takeover targets
├── all_urls.txt              # Deep crawl results by Katana
├── js_files.txt              # Extracted JavaScript files
├── sensitive_files.txt       # High-value files (.bak, .sql, .env)
├── clean_urls.txt            # De-cluttered URLs (Uro)
└── reflected_params_xss.txt  # Parameters ready for XSS testing
