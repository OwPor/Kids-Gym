/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./index.html'],
  theme: {
    extend: {
      colors: {
        coral: '#FF6B4A',
        coralLight: '#FFF0ED',
        navy: '#1E293B',
        golden: '#FFD166',
        mint: '#06D6A0',
        cream: '#F8F9FA',
      },
      fontFamily: {
        nunito: ['Nunito', 'system-ui', 'sans-serif'],
      },
      borderRadius: {
        '4xl': '2rem',
      },
      keyframes: {
        marquee: {
          '0%': { transform: 'translateX(0)' },
          '100%': { transform: 'translateX(-50%)' },
        },
      },
      animation: {
        marquee: 'marquee 26s linear infinite',
      },
    },
  },
  plugins: [],
};
