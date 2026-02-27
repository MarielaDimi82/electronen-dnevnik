import { useState, useEffect } from 'react'
import api from './lib/axios.js'

function App() {
  const [grades, setGrades] = useState([])
  const [user, setUser] = useState(null)

  // Тестова връзка със сървъра
  useEffect(() => {
    api.get('http://localhost:5000/api/classes')
      .then(res => console.log('Сървърът работи!', res.data))
      .catch(err => console.log('Грешка:', err))
  }, [])

  return (
    <div>
      <h1>Електронен Дневник</h1>
      <p>Свързване със сървъра...</p>
    </div>
  )
}

export default App