# Remember This commands

Run as `"$CLI" tool <name> key=value …` from the vault folder (`$CLI` is found by
`using-the-app.md`). `"$CLI" tool` lists every tool the app has; the ones below are the ones Remember This
uses. Tools named for Clerk.AI, Mind My Money or Revenue Magnet (`period_close_*`, `naf_*`,
`list_sets`, `create_set`, favours) belong to those apps; do not use them here.

**Needs the app running** is marked ●. The rest read the vault and work with the app closed.

## Looking things up
| Tool | What it does |
|---|---|
| `search_captions` | full-text search over photo captions, transcripts and the text in photos |
| `search_transcriptions` | search voice memo transcripts |
| `search_ocr` | search the text Apple Vision found in photos |
| `search_by_person` / `search_by_location` | photos with a person / at a place |
| `query_assets` | one read-only SQL `SELECT` on `registry_items`, or filters (`date_from`, `date_to`, `person`, `item_type`, …) |
| `get_asset` | one item by path or text |
| `get_stats`, `list_recent_items`, `get_pending_items` | what is there, what is new, what is still being processed |
| `get_people_stats`, `get_location_stats` | photo counts per person / place |
| `list_people_entities`, `list_places_entities`, `list_group_entities`, `get_entity` | the people, places and groups the app found |
| `find_vault_files` | files in the vault by name or path |
| `parse_tslog` | a time-log file as structured entries |

## Photos
| Tool | What it does |
|---|---|
| `open_review` ● | show Markdown files in the app for the person to read and talk about (`paths`, `title`) |
| `reveal_in_photos` ● | open a photo in Apple Photos for the person |
| `attach_photo`, `attach_photos` ● | put a photo in front of you (save tokens: only the ones the question needs) |
| `export_asset` | write a photo's original file to disk (starts the app if it must) |
| `rescan_photos` ● | look at the photo library now instead of at the next sweep |

## Changing what the app knows (only what the person states)
| Tool | What it does |
|---|---|
| `update_entity` | a person or place's `relationship_to_user`, `is_me`, `aliases`, `groups` |
| `update_entity_notes` | the notes on a person or place |

## Sessions and questions
| Tool | What it does |
|---|---|
| `trigger_dreamer` ● | hand a job to a session: `cadence` (`narrative`, `detective`, `weekly`, `monthly`, `biography`) and `note` (the request); a running session gets the note |
| `send_dreamer_message` ● | a follow-up for a running session |
| `list_open_questions` | the question cards waiting for the person |
| `answer_question`, `dismiss_question` | answer or drop a card, only with the person's own words |
| `ask_question` | raise a card for the person in the app and on their phone |

## Setup and settings
| Tool | What it does |
|---|---|
| `get_config`, `update_config`, `set_language` | read or change settings (change them only when asked) |
| `list_identities`, `create_identity`, `set_active_identity` | whose archive this is (a person, a family, a business) |
| `add_cloud_source`, `add_device_source`, `detect_volumes`, `remove_*_source` | where the archive comes from (iCloud, an external drive) |

## When something is wrong
| Tool | What it does |
|---|---|
| `read_app_logs` | the end of the app's and the daemon's logs |
| `preview_bug_report`, then `submit_bug_report` | a bug report; show the preview and send only after the person says yes |
