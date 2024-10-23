// pages/api/allowed_ids.js
export default function handler(req, res) {
    const allowed_ids = [691763, 339860];
    res.status(200).json({ allowed_ids });
}
