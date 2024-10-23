export default function handler(req, res) {
    const allowed_ids = [691763, 339860, 78910];
    res.status(200).json({ allowed_ids });
}
