RSpec.describe Song do
  it { is_expected.to have_and_belong_to_many(:languages) }
  it { is_expected.to have_and_belong_to_many(:categories) }

  let(:song) { described_class.new(params) }
  let(:params) do
    {}
  end

  describe 'formatted_chords' do
    let(:params) do
      {
        chords: <<-EOS
          {title: You Are My Sunshine}

          {c:Verse 1}
          [G]The other night dear as I lay sleeping
          [G7]I dreamed I [C]held you in my [G]arms
          [G7]But when I a[C]woke dear I was mis[G]taken
          So I hung my [D7]head and [G]cried

          {c:Chorus}
          {soc}
          You are my sunshine my only sunshine
          [G7]You make me [C]happy when skies are [G]gray
          [G7]You'll never [C]know dear how much I [G]love you
          Please don't take [D7]my sunshine a[G]way
          {eoc}
        EOS
      }
    end

    it 'calls Chordpro' do
      expect(Chordpro).to receive(:html)
      song.formatted_chords
    end

    it 'returns formatted stuff' do
      expect(song.formatted_chords).to match "<table>"
    end
  end
end
