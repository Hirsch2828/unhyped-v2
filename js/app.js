// Milestone 1: show the topics that come from Supabase through api/stories.js.
const list = document.getElementById('topics');
const status = document.getElementById('status');

async function loadTopics() {
  try {
    const res = await fetch('/api/stories?topics=1');
    const data = await res.json();
    if (!res.ok) throw new Error(data.error || 'Request failed');

    list.replaceChildren();
    for (const t of data.topics) {
      const li = document.createElement('li');
      li.textContent = t.name_en;
      li.style.setProperty('--accent', `var(--${t.slug})`);
      list.append(li);
    }
    status.textContent = 'Choose up to 10 topics. You can change this later.';
  } catch (err) {
    console.error(err);
    status.textContent = 'Could not load topics. Try again in a minute.';
  }
}

loadTopics();
