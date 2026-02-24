# Mobile Web Dev: Responsive CSS (Flex + Grid)

## Assignment

Take two provided pages (**HTML + JS only**) and create the CSS to make them **responsive**.

- **Page A (`index.html`)** — use **Flexbox** in your solution.  
- **Page B (`gallery.html`)** — use **CSS Grid** in your solution.  
- Both pages share a `<ul>` navigation and **link to each other**.  
- Handle **3 sizes:** desktop, tablet/small laptop, and mobile.

---

## Logistics

Submit a **link to your working code** hosted on either:

- **GitHub Pages**, or  
- **The School Server**

---

## Instructions

1. **Download the starter files** (provided below).  
2. **Write the CSS** — one stylesheet per page:
   - `styles-flex.css` → used by `index.html` (**Flexbox**)
   - `styles-grid.css` → used by `gallery.html` (**Grid**)
3. Make both pages look clean at three breakpoints using **CSS Media Queries**: 
   - **Mobile:** ≤ 600 px  
   - **Tablet / Small laptop:** 601–1024 px  
   - **Desktop:** ≥ 1025 px
    - Note: You may optionally make these pages your own: 
        -  different HTML
        - change out the images
        - add JS,
4. Keep the **nav identical** on both pages. Ensure links work.
5. Test using **browser DevTools** or by resizing the window.

---

## Deliverables (Upload as a `.zip` if not hosted)

Include:
- `index.html`, `gallery.html`, `app.js`
- `styles-flex.css`, `styles-grid.css`
- `/images/` folder (use the provided images)
- *Optional:* `README.md` with notes or credits

---

## Grading (10 pts total)

| Points | Criterion |
|:--:|:--|
| **2** | Flexbox used correctly on `index.html`  |
| **2** | Grid used correctly on `gallery.html`  |
| **3** | Responsive at 3 sizes (layout, readable type, spacing). |
| **1** | Shared nav works on both pages; pages link to each other. |
| **2** | Polish: clean spacing, consistent fonts, no horizontal scroll, accessible alt text. |

---

## Submission Notes

- Your code must be **reachable and working** on the school server or GitHub Pages.  
- If any parts are **incomplete**, **comment out** broken code and add  
  ```css
  /* TODO: explain what you would finish here */
