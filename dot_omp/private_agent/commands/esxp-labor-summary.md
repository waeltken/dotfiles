---
description: Summarize the currently displayed ESXP labor week without modifying anything.
---
Open or reuse the browser, go to https://esxp.microsoft.com, and navigate to Labor Management → Labor Entry.

If Labor Entry is already open, reuse the current page.

Then summarize the hours I have registered for the currently displayed week.

Requirements:
- Read only. Do not edit, save, submit, approve, or change any entries.
- If the site is not logged in or blocks access, stop and tell me exactly what page or state you reached.
- Use the currently selected week shown on the page.
- Report:
  1. Total hours for the week
  2. Hours by day
  3. Hours by work item / assignment, including customer name, assignment ID or title, and per-day breakdown where visible
  4. Category totals (Dispatches, Support Packages, Opportunities, Overhead / Non Project Hours)
  5. Submission or approval status for each entered item if visible

Format the result like this:

Weekly total: HH:MM

By day:
- Sun DD-MMM: HH:MM
- Mon DD-MMM: HH:MM
- Tue DD-MMM: HH:MM
- Wed DD-MMM: HH:MM
- Thu DD-MMM: HH:MM
- Fri DD-MMM: HH:MM
- Sat DD-MMM: HH:MM

By assignment:
- CUSTOMER — Assignment ID: ... | ... : HH:MM
  - DD-MMM: HH:MM
  - DD-MMM: HH:MM
  - Status: ...

Category totals:
- Dispatches: HH:MM
- Support Packages: HH:MM
- Opportunities: HH:MM
- Overhead / Non Project Hours: HH:MM
