describe SensorWatch do
  around :each do |example|
    Celluloid.boot
    Celluloid.start
    example.call
    Celluloid.shutdown
  end

  describe '#record_race_results' do
    it 'updates SensorState, Heat, and Run database records' do
      sensor_state = instance_double('SensorState')
      heat_class = class_double('Heat')
      expect(sensor_state).to receive(:update)
      allow(heat_class).to receive(:current).and_return([])
      expect(heat_class).to receive(:post_results)
      sensor_watch = SensorWatch.new(sensor_state: sensor_state, heat: heat_class)
      sensor_watch.record_race_results('race reuslts', {})
    end

    it 'triggers a board update'
  end

  describe '#start_race' do
    it 'calls #new_race on the track sensor' do
      expect_any_instance_of(TrackSensor::Base).to receive(:new_race)
      sensor_watch = SensorWatch.new(track_sensor: TrackSensor::Base.new)
      sensor_watch.start_race
    end
  end
end
