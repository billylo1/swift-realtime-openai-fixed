import AVFoundation

extension AVAudioPCMBuffer {

    public enum AudioError: Error {
        case pcmBufferCreationError(String)
        case baseAddressError(String)
    }

    static func fromData(_ data: Data, format: AVAudioFormat) throws -> AVAudioPCMBuffer? {
        let frameCount = UInt32(data.count) / format.streamDescription.pointee.mBytesPerFrame

        guard let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount) else {
            throw AudioError.pcmBufferCreationError("Failed to create AVAudioPCMBuffer for Realtime")
        }

        buffer.frameLength = frameCount
        let audioBuffer = buffer.audioBufferList.pointee.mBuffers

        try data.withUnsafeBytes { bufferPointer in
            guard let address = bufferPointer.baseAddress else {
                throw AudioError.baseAddressError("Failed to get base address of data for Realtime")
            }

            audioBuffer.mData?.copyMemory(from: address, byteCount: Int(audioBuffer.mDataByteSize))
        }

        return buffer
    }
}
